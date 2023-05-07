using UnityEngine;

[CreateAssetMenu(fileName = "Match", menuName = "Match/Create new Match")]
public class MatchBase : ScriptableObject
{
    //Match data
    [SerializeField] int id;
    [SerializeField] string matchName;
    [SerializeField] int age;
    [SerializeField] string description;
    [SerializeField] MatcheLikes Likes;

    //Access properties
    public int Id { get { return id; } }
    public string Name { get { return matchName; } }
    public int Age { get { return age; } }
    public string Description { get { return description; } }
}

public enum MatcheLikes
{
    Pizza,
    Burgers,
    Grass,
    Horns
}
