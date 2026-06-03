Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07811477E53;
	Wed,  3 Jun 2026 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512684; cv=fail; b=ayRNzQwrP1/K/XmtObVFthSmakRHZuK3HqyCWCESCHQEBU6wPOsDAUpeY+xbQ7oQ24a6xBHUEY7SVBlSTRid4wRTEaIKx9THGwVwQWsv9l2LoGKz7lx0M2do4WTJr5C6Yvpxp8kFTb719zp0DzjmG0NLyzGTic7MNMM/8SH/wEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512684; c=relaxed/simple;
	bh=91oY3m11UFbY0EEwJ+6tpRe54r281e5lG0pe+lad5MM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nCj/it8MrxHqn3kMRS0ZqF6wVH9Xwuj9iyQkHQyzUvFt4ZIaePsuS+JwvsJszpgoqOdIqQefnpvfmZDkrPzgHbfxZ5SouK8nwdkbubnib/PPXyPWrHq4cQiV4bJqIjAx3vOswNeDlRVeogib0B2UDy8xB10Mn/Xo6A4He4pLAq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zHe6EFkL; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zHe6EFkL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erme1qjtzDFahg/coCS9qSDoRcKm28iYXQsxmiUv6+pcB5Qzw2N0VJzgBOf4C+BpW89my6BkzaKlIg8POc4bmTC640Iv1DsPqWtYBN4a3U9h5EWl4nf5/ULn/fudDf37b/4krobBFnimvm35lAU6P7GdfNoBOYFmKYYVGILV/goXK1iYyE/y4Lub88U5Kvfws9YJkz93QgltkX+dxGr223/zxMPsyIr8+I3SO18ej6AUXLRrcHjE68HNiUqWgKSf0M+Ipf8MhlQy7VMYRtmnGFFiQmFMQH5plDgEh8ctA+6/xCbRj6XflJ1G55a7u/MdIra3DvDy9+tlhZU019siPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvkVuq7YpansZL5lU7VQFzhJ1nVhG5YxcrXzXtMg4OI=;
 b=fUR/f0gTyVpg5tqj3urte4s4otzOw17Q7dcWwuqgNxBh58g596McuGmwRYtltvlLbnAU7xI6RnEF/m8ZpDCYgCKFaE9zVhoGS9bDvBeG7+eH0BxXp/4i+s9CXu6UULiilQqfRQPItb33j+/G2V1+86JN3WonuWqWVShojnp7wXh1aYpNRyl13zrSc2GIapZGcMe7FlqSQyZL57yJopNF3FSZpNFsAukcGo0/SD4oaecGkJkCIOxkCNd/jHNIPylQWSlN+ohhrFbaWq13iKtAnRKIDFd8YN9HXuXu7JBEFz1GIHMn2WAdJRQeuV+IsWn0G2Gd1Iz/JFjrRKE1X9K5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvkVuq7YpansZL5lU7VQFzhJ1nVhG5YxcrXzXtMg4OI=;
 b=zHe6EFkLBGPDd4kzTibgq1s4spd2zf8gweel/GibyaUXAQwvHbRT05tYiOXr8OyuSOb8PXmg9JY9yE3NSnub1zZasfqCz5/JDwy/dBcjjiEPCsS8GlrnkX4WzgYXv+ao/x13q+ghzvFU2c3ptwlTFyXwIAOGCio7EhCpWbbW+xA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:51:20 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:51:20 +0000
Message-ID: <916681a5-dd66-4773-a46f-2273a72c11cf@amd.com>
Date: Thu, 4 Jun 2026 00:21:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: guest_memfd: fix NUMA interleave index
 double-counting
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org
References: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::32) To BN9PR12MB5259.namprd12.prod.outlook.com
 (2603:10b6:408:100::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5259:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 72881aa2-d7ad-49ba-b439-08dec1a11a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	VfDPmh/OP1hyR4Vp+BrZvcdKDk6IoNmtfuIb3n1zkq7BgmoBXatEiOZVi2XGX3vZO3mN52um9Zyy7wyW5w4GTrQn7kviReQCc54vMHyltOLEzImi6HL/Yg3n1+JX3dS+KFhPrOVEKp71EgsWhBjIA5PmmR5PrHGB1ZQSpV6X3HvhwZbBWE/IW4U9xomrK1ZcF3R7eS+IU5nVPqruruBk3qcFSiDk5MobQCOTHRjVJRey7c4s6EcMTCTEqoBqSjn6U+82mlxLAU2R0iB06ylrSTXLHhOf92Mk4sfNfW/JOzVyzjITEWthKYAUIT5HpIlp2kq0Bzs/AcF273QTAaEBefetB94aAuU4qC3Hr5nI8dh6jAYsZ+2+qDbXfFuXT8y8fTZ3SvR7c1+eB1ce5L6IntHkSVlC2NMxLWG1KHmzuI3IcFECAb3ua9XGfv5GLVlURpOZGuzwn1cQtDrH0fF17cMnjn/ydNj8ZfhJ3GCXUosUXYBH7Agnzz245grz/RifPKKGsws1v9GWxpW6eR0HJLjZKKPVdfE3UT5NWv1btsB7DsiiskH51J5Kne2H+/7wNE3gBYy+H0DuIUZ9HmpHO3rBGIjUWORHNSQpgMJYgXXIe5DlyrdxBA2noxPm1Tf8z7hBbTFEilZgQS27LX0KQTEkiVSupDwwlUOo9GrqQhUbGcNQlvO/vchSmwVje0u9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rlh4b1kxaGpLYSthSzl6bVRxRUxIUENqWWdibnY1Mkw1MU95WjFOYXJJenJK?=
 =?utf-8?B?N2x1cVR4NnFCYkJXeDYxazlmeEYweEx3bjR3dEplRi92VDRpNVpoTVFQQkR3?=
 =?utf-8?B?YWFRVi8rdmhqNkVOR0NGRFR0a2YwenM3ZmQ3TDNVK2ozWVlHUTEwMkp2TzNW?=
 =?utf-8?B?dC9BSGZacDhXRjU2NVEwZCtqNEYzTzF5T1VxK2xpMFg1Zk1FUnJzZ1pHNGFr?=
 =?utf-8?B?Vys5WUI5NEUzd2t6OGFOTGMxOXBqN0NLeDZBQjcyOXdWcEd6Z09HMXJTcHNz?=
 =?utf-8?B?TEJKc2J5MHMxSGd0UTl3dkUwdThVWWxxS0t3UlVhMDJJVW95TkVaRjVhWFg1?=
 =?utf-8?B?cFlaUGo5NWYzZG8zNmNFbWNlb2pycWk4L3phS2tKTWhKa2daK3V1SU13Lzl1?=
 =?utf-8?B?SW16VDlibkFZRm5rZEdGU1d6eTBxRlZlSWg5eUNjeXZuelQ0WnJnd3RkNnBi?=
 =?utf-8?B?b1hoYWlmZVlsa2ZzV0JvZmxsaHZRYU92cUl0Nm1TRG9EMVNnVjVhQXMyMGFP?=
 =?utf-8?B?N0d5M0FwWUFBQVZqb3VqSGxiSW94RnFGOFpSNFd2VVJqSEluam1JeG5NazhX?=
 =?utf-8?B?MVhPSWYvYklna05yVVliK29UMmp0c09RY3NPcGNsRzBTTm9zSW5PZHFzb1Rz?=
 =?utf-8?B?WExsUzdGMnd2c05xWTBEMG9qRm9GenhFckpvUVNFWkEzcEhDbDFMelFFV2t6?=
 =?utf-8?B?Uk4xNlN6L0RNbFVYQ0s4dzBYbTJXTDF0akxvVEZNTG5yRHR6bDVBVXBreDVs?=
 =?utf-8?B?MzZMU21zcTZ6a2pWQXJPY0ZsN0E1TzJTOUM2ME1jeXpSYVRXUityb0xwSEo1?=
 =?utf-8?B?ZGRxVmhmS2gwTnVCT2szTW1RQjlBT3kvVUxrSUZHVHMvUW1kaGd0cStEbW5j?=
 =?utf-8?B?OFV6ZkhlYkVLTGRQZGl4V1o0QWdReEtyaWNDNEx2Y2o2UEFMb2J4aElJUW0w?=
 =?utf-8?B?SGd2ZTVSd2JabWFvN2hXZlJhcDZ5djZ4dzRmZGRQdGNlbnJ6VC8xUHhUR0o0?=
 =?utf-8?B?dVg3T0hjMGZQVThUMnZDYm13ZmltS215MnJ2RVZXajhQVjRrRkZWYzBSR0hV?=
 =?utf-8?B?S2c4TXhRc2RLM2lwc1M0dWtCWGxQZGNRNCtBaURjYmEvVkNpSXQvcy83WU4v?=
 =?utf-8?B?T2J4UWVwSEx1U3ZKbSs3Vnl3dWdGVXd1RHVHc2NwMmRsbndEVkxVcVNEVDlR?=
 =?utf-8?B?RHlyc1Ezc29HMzVOVXNnS0U0L3Z0Wkl6ZWY4NG5HWHcvRFZHUlBQSXpaSWY2?=
 =?utf-8?B?OHZIMVpkcXRHaXJBL1Yrd2JqQmRzRjdmeXN6M2JIc096UVpWTmludU5mY0pY?=
 =?utf-8?B?TXVKa09KMDhPTVFlWS8rb3NiY1Q0dnJLV2VJWVBpMWVjWVpsZnpFbFp3dktn?=
 =?utf-8?B?WS9XM2F4MWVwSlNoTVppcmFLYktNZjBSVEEwMjByWVl4elRsRXZiRWxBKzB6?=
 =?utf-8?B?ZzVoS2x4cHoxS3NqTDZOK3FPakJia1VSN0lUVk8zbk1PQ3lDNmJJRjRLdmpE?=
 =?utf-8?B?QTN5aFMzRTg2VEx4a3Iya2ZFY2NlZ1ArRVQ0M2dpZUx0SFRJMjJBK3JhRmhL?=
 =?utf-8?B?Q21GNU5LVitSSUNiZk51VVlQV3dNazFhand3elZ5RDU1eitIMEVialVhaGda?=
 =?utf-8?B?U0NzWE5ZMitxVUJ1SmUwalZJUHVxRkZpSkk1dC9IQkJBN3R2dmFZVlhnSlFQ?=
 =?utf-8?B?ZTJ1L2tWRDZockI2TW9DWlFSZGpkL2hsbXA1OEplNjFSelpoWVZURFcwVW9D?=
 =?utf-8?B?L01tU2t5aVNDK2FLbXcxbUpNeVhndlFJWkdzS1Q0azJwVkxKQTZtMlZkWStO?=
 =?utf-8?B?Q1V0dHd5QzVpMGdzcmVaUjZDWDRKQklQRUY0VkxGaEl0djlDUU5TRlRvT1U4?=
 =?utf-8?B?YzAvK0YySVR1R0E0ekdYeDFUZVYrQXJPdEUwRkRuZVg0U3pTZmhtaEJYOC8x?=
 =?utf-8?B?bWlTU2VVMlhTZ0FjbTY5SURnT0lGeUdXRS9zck9mb3RtdW4vYXJPZXNjTzl2?=
 =?utf-8?B?c1ZtR005TG1vRWU5M2NGSVNsS05oQkphWk5NTXI4K2l6aGFpdmNEVFhOcDM2?=
 =?utf-8?B?emdRZ3J2Y2hlU3d5cEJwT0p0TGFjdjBjZmM3TFdKeGdpZFExSDhHVGh3UUU2?=
 =?utf-8?B?bEtQN2h1TVA0R2pHTkd1QzBKZk1qaUErWlJKYjhoQ2V3Wm5TWjFEeE5IN0tJ?=
 =?utf-8?B?SGFyNDM3RDcwalpMWnlVN0syaStDWFR3Ynp6Qk95Q1gzNk95ZVVpNGNYZDR4?=
 =?utf-8?B?amtaOGQ1QTl0U0lKQzZrdkhHUVVUL2pzWVc0MUVIeFRrYllxcFVJalBhZ3U1?=
 =?utf-8?B?ZW5LNmZRd3N5blBLbVo3TDMzL3VKeThKcVQ2MkxCZGlKU0tuVVcrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72881aa2-d7ad-49ba-b439-08dec1a11a0a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:51:20.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5+F6YOvGH7ZollzmLQAFrvnY5T8taQjVJ6R4Ec31JtMWWZxZYFzuO3vLQROh6pg5OaLA/EpHq6Byjq9e4CL+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793



On 6/3/2026 9:27 PM, Michael S. Tsirkin wrote:
> kvm_gmem_get_policy() sets *ilx to the full page offset
> (vm_pgoff + vma offset).  But get_vma_policy() adds the page
> offset on top of *ilx, so the offset is counted twice.  This
> causes NUMA interleaving to skip nodes: for order-0 pages the
> effective index jumps by 2 for each consecutive page.
> 
> The get_policy vm_op should return only a per-file bias in *ilx
> (like shmem_get_policy does with inode->i_ino), letting
> get_vma_policy() add the page-offset component.
> 
> Fix by setting *ilx to inode->i_ino instead of the full page
> offset.  The page offset is computed by get_vma_policy() in
> mm/mempolicy.c. The full offset is still computed
> in kvm_gmem_get_policy() for mpol_shared_policy_lookup().
> shmem_get_policy() follows the same pattern.
> 
> Found by Sashiko (sashiko.dev) AI code review.
> 
> Fixes: ed1ffa810bd6 ("KVM: guest_memfd: Enforce NUMA mempolicy using shared policy")
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  virt/kvm/guest_memfd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 69c9d6d546b2..0bcf6fc08e2d 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -438,11 +438,12 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
>  }
> 
>  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> -                                            unsigned long addr, pgoff_t *pgoff)
> +                                            unsigned long addr, pgoff_t *ilx)
>  {
>         struct inode *inode = file_inode(vma->vm_file);
> +       pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> 
> -       *pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +       *ilx = inode->i_ino;
> 
>         /*
>          * Return the memory policy for this index, or NULL if none is set.
> @@ -453,7 +454,7 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>          * can then replace NULL with the default memory policy instead of the
>          * current task's memory policy.
>          */
> -       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, *pgoff);
> +       return mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
>  }
>  #endif /* CONFIG_NUMA */
> 
> --
> MST
> 

Thanks for fixing this. LGTM!

Reviewed-by: Shivank Garg <shivankg@amd.com>

Best regards,
Shivank



