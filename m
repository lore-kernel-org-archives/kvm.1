Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372935AC20;
	Fri,  3 Jul 2026 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090200; cv=fail; b=UHoYX9WHjE4A0ySoya3VOGA6cMrtn6bC1tr5zL/yEWXWXauSBJPzEklkX3Td4hHdaArY413BfDGOGmNLhTzgI5/sKRUO/6IaLLaQQ4k9sa2ObwNZiYS4iVJhq6A2lDEtgabBqRwYAylZAofUG6eFTZ+v/l6SDgP+Hw9ZhZOeHXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090200; c=relaxed/simple;
	bh=ZrbxSY527Z2UvbVfNKyYgQVuYZO+UdjpuVRRVXaG2N0=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=BfvWT9NHWDuW+AlybNiouNL9bpY1czGb1Dn4O4D3f7IXoxRm8rqlCnQD1g9J7hvCpPpvp5eXT/C4ztpaG9Jmagn7ydTm3hdo+mTW97ZByvXdoigrZYzaQR7b4JT92Hh3BXM0enTZuaWDQyizJl2NfD8xdYrDpHxepXCM8VinzPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MkAQ9Xwo; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MkAQ9Xwo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8NN+qkFZJ6IdxQK618m0NKtmtq2J1MIRvtRAJut+IfbFLlIVYt3tVKj5hY8BjasKifHeY4stwSBhgLzPW77Begzn+4xP8iF9iAGuqMqu8VCexEHxVG4/fHyFaL9xNE+aPsytJoa3uw8LWVKAFMGqy2Zg0BjT9IMqUaTFuIbYCR9podg/8OpyT/LCP/yFPg8Gelefk6hzPp7M9+32dKtcnOkKuODNhzNZ5rkQy0ZMdu06QKxSBXIBcQvz0CFcYG7uwnQLf7Gx7J47vxyP4vHqxBH3ytC2PiQ+wxKjepXct7QBl1/WeRhdGmmfrVcg36Ysor9gukTkE9HAISx7Oq59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owIJ+y6L5dPY/yexo+L9nqreRKeVwi4O5AKNA0AoQSY=;
 b=PHPsidHcfHSF59m/Z1Nx92E3F7EANvMgJrdNY8PmMhpcLY+XAWrxtIM1gAPnoiwH59LucDRtetBCpJf8cnC9mQDUYD9bZlgoSUGwESsTLziAK9dpJbn2+pAwovKxdBrisw9rsWBc3aq2B1VZ9abwxjQ/ij9OIX+7dRVfwB5/CSMeBNjiYQbg2RjSwNrZ22KoYflzlRq0tp+DRmYfB8Zz1YloqxE9GwqmAc5DKLLjA/ugLMqPEfu+gMYc5G3u4WlBFH2ljn6Xkr7bAw2DNUDzszNuNCoCQwNFBOGOCxbRpH77/V2BUYHABWqcJu3DHR/mMlxP4Kj7K3ipNc76tYzdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owIJ+y6L5dPY/yexo+L9nqreRKeVwi4O5AKNA0AoQSY=;
 b=MkAQ9XwojNIZAuE25fzWdacuNn6OXkoWgHpWuaKVLzq5hIL7gZAwLQM1AnAci2zuGeh7VyfIKdjDUhJ3qRiqBZUtgHOZW52V3SgTlZ69SoXS6+TDSjDSiKC+ef/bpRCMHWIC8A7h2D3CQRNRcJ+HC3GG1UgffGC6mxKm2/0ZKWyAKzCmsrgUMiMelv8xmOiwO9sxtJAqvWOzbyAgZXF3IEjm/PO9PBcS6CrBkG04st6GiJ8x+KajVyouqXE9HBXkTAbPz2fbXp9qUKV6BnfxauOgDisSi1kvZlN17NC7CJyjuw557+QjGQYrr/pX+hSEu57+ik4p51Oc3rFGGl9yCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 14:49:55 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 14:49:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 10:49:53 -0400
Message-Id: <DJP0PYJX6W7W.1RVON21CZGFJL@nvidia.com>
Subject: Re: [PATCH v5 09/18] KVM: VMX: Use higher-level allocator API
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, "Gregory Price"
 <gourry@gourry.net>, "Alexei Starovoitov" <ast@kernel.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Hao Ge" <hao.ge@linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <derkling@google.com>,
 <reijiw@google.com>, "Yosry Ahmed" <yosry@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <kvm@vger.kernel.org>
To: "Brendan Jackman" <jackmanb@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Muchun Song"
 <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park"
 <byungchul@sk.com>, "Ying Huang" <ying.huang@linux.alibaba.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Hao Li" <hao.li@linux.dev>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-9-c87b714e19d3@google.com>
In-Reply-To: <20260703-alloc-trylock-v5-9-c87b714e19d3@google.com>
X-ClientProxiedBy: BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::17) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: cd677acd-a8d1-4422-2a86-08ded912585e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|921020|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YwfbSqEU1hoe8S/0ZkYmaY/gP5nbsm11UtJUMxGr9yvkEp+ihWQSSlxv7xBhOkjs//KXyvF2zLhMF4A76YacoA7r3xg6jzR5K27zrCeAssLm2OVpiNSMJcQL09GDdkxeVuva+Ai7zSw0O1U6iXCsMZ9gVUGqWzLQp2M0QYCFAw3GDmHh52UN6g4ml38kVObc2pgRLc0TMVzuhPDnzOZ9HtccjKBfjVLFAPDBIeiVgiBEVe/2uTWvWI85QYNs5eyjSZrJYRiFg+6QqJXIXHhK97RV6pRi6YVqZG9tTngM7+J0zFsPj5QxnANIv2mEM5XFSAFkCaOWzNgo7sphWRaSCLoMURr4vGdTDCEAl0b3kFhg1a8Y08mYSmK+SBUPEbGVFqmMgtTQoLhr7+3fu8+UEZnb6yWK1xUdYTl6lIIvk3FaWIh6XQIXYXnLbMZLGbNZBr7v9kh1yCY64f3dj8sSsT5drXHaSGZDp+kItJdkCDQy7Ui1eFtXakVRWTTYSB0ZhgSR8GNwQmz0JFuzkR5jvwmtW1kURZLdJM0TvlNW8G1iZYJ328UEatnjMEH5+UOS4/dzYVSBJW+bvm5iTIieT81QyoXAtUL8TQ3/sSjK/pvzPQuPpilkgi1VIMUMuphtRH1ecMXJwy5Jhy3h2X/FTFcM8uzivcMI9YVnNgvgMHdKcddUacECVZPetmNUu1eF/pIhcEPR5F1ADRGobN48Jg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(921020)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enp4dWhBb3l1RmVxaHo1ZFZ1clFyRExQZFBtemZVcmljUTc0ZHFjZGRiMEpj?=
 =?utf-8?B?VEJvS1lMc3NuOXZYbXZNUlFVQ045OThpVmNQRFVnTzM4ZmVjUVJSL0xod29l?=
 =?utf-8?B?cE0xeDZtZ0ZBNnZiOE5iV3pnUzFBV1ZnREJQMzJYb0FZcm1ZTStDUzZiYXZs?=
 =?utf-8?B?bnpWZElPeEVmT1IrdTlWbmtxcGtaOWdVTXBmdTdTUWwvMk5Rb1RWbVJjK3Fi?=
 =?utf-8?B?aHBPYno3aUc4dm1RbmpPTEJTdEVVdGNXRUpUakRmaG5yMVNrUU8rVVkzcGwx?=
 =?utf-8?B?TEZYQ20wTlhqYXVvdzRNTXBZeHhZOWM2empnOVVYd2lOek1NZzVSTVJ2QkNK?=
 =?utf-8?B?bEJpMmJITHZKY1RzL3JhU01HK2lDT1Z2aUN3bEthaDJrS3NmNnJKeDYrdkho?=
 =?utf-8?B?Z2o4c2xmRlZZemRSd0JDN0RHYkVFT20zNG1VNm5KVHlzcmdDREpBOWFYOEVa?=
 =?utf-8?B?K3VGM09Mci9pUUljb3VnVURPcUh5NHBoMWpnSXMyc0JjVExuQnBqUkhYSkVz?=
 =?utf-8?B?WnNvdGptM0hZVzVpMUdXMHFPQ0hIVE8yOWo5d0RGV2xaTCtGT2Q2ZkE5enBC?=
 =?utf-8?B?aTdobG9XM3hhMUIxVjN4R0o0MzdQVVJ5TkZuOEJTb2hYUk1pMVdLU2lQR0xr?=
 =?utf-8?B?Wmtma1pXRTBVRW1rajlaUXFDSnNsQy8xZjQ5dkZGcFFYOWs0YnVhbHBPbnha?=
 =?utf-8?B?OFQ2dmpPS1k3c2FpRXo3UEYzQlJPeUNrRlEybVVtY3hGcW1JTHhPOUloWXJ2?=
 =?utf-8?B?TGNzd0hWZkFFc1RsVHFGb0t1T1lQaktkczRjK2I5elV6REZhZUZPSGdMdlIy?=
 =?utf-8?B?S2praGpSaEZZb2tONWQ1NklZOE9YZ2w3WUg0OG5pQytpNzJOakdzSTV6ZkNN?=
 =?utf-8?B?aDFCWVFZV2t4YnJoV3U2VExMUDlITWRsakE1K0VoM3A1WlV4Y3cwMXBLeXRt?=
 =?utf-8?B?M25FRDNLUUVraWpqVGkxeEZFMDBLM0p3OTZIL2d3cjVXNnlySHpEcTFEYXJy?=
 =?utf-8?B?M3lMMERhb3pPbzdqd2g0UEFlQTVNb0lrbjFaUXFQNzZLVHRzYjIxOUdiQitT?=
 =?utf-8?B?SmtuSWIrd3lneXlndTlBWTl3MSsram1EQlJteVRQZmtCVko2OVhzYTgzV0hB?=
 =?utf-8?B?Z29kMU4rem1PdTA2VmpqZ0ZoeCtycWdtVlhMWkMyMjB0ZVF0c3VqYU5GUnJ4?=
 =?utf-8?B?eTlRang3RURydVVwYTBGdzM3T1pidm1WMGdkR2ZzY1NkYWVrYmdnN1VjU0FR?=
 =?utf-8?B?UHhScVVUSnlrNDltdnc3TVM0TGc0YkJmVnJjdEIrQVEvUzVyZjkzUytaZGVk?=
 =?utf-8?B?WTJwSVROMVE2dWJJS2o0TUZoRmVPRE14NmcrdDFndEc2MEw5R290YlFSRXho?=
 =?utf-8?B?S3hNaFBXOWhjRnhwVGpRbUhKMCtrSzFFTmVNNWVvL3dLenRPTlNibEN4RVl2?=
 =?utf-8?B?dlphV0Y2WTMvNktRUEplUDJvTlpydHBudGRPT2tPM01OWjhQM1RjMDVsaFl6?=
 =?utf-8?B?dDM0ejBMbVM1cUgzT1RLN1B5ZVNydUd3VCtOeFREZzVYRzZNZERLTVBYLzE0?=
 =?utf-8?B?Zk9xRk1MZ0RzVnlrQythNGtIUm8wazdaUU9rMUdYQ0dJNXpKVTRlb1FwemhF?=
 =?utf-8?B?TUYvd3JRMitYOVdwT1FwcEFUS2pqMGlRY3RZY1hQVnFBOFdFN0FOSFl0SHpk?=
 =?utf-8?B?RmhtRllGcDJucGR0T0lZeFlRcXlVMnRLQ0VDWm85a2lDbW1Md0ZOZzczazJG?=
 =?utf-8?B?VWt6bUxOUzRmenV1L2IzVG9Pb2FacXNFL0xZQVNUc00wYjFsVy9ENmxMa3k5?=
 =?utf-8?B?d3JielBFWE1SK3VmczdpUWRFVk8xT2JpT05qVzBLUTBQVnpHVkV4UUhNM09r?=
 =?utf-8?B?QmJaL0d4K0RhZTBpSCtUOVkySjdjbVNzeUt2V3Q5cVI2R2dJOG9ReGVoWEhC?=
 =?utf-8?B?NWtJL1BvUGsyQ1pJMmtnUHliQmJQd0lZSXM2NFlsSFljYTZlTFdsK0UxT1VK?=
 =?utf-8?B?eStCRGcwelNySE5WQ0RKd1NRUnIvVmJBc0NlU2IxL0FlUGp1SnpKWGNWRUc1?=
 =?utf-8?B?bENQc0NWMkhXZjF5dm1GUmpNVXdLYzdKU3gyQ1czTDRPQ282Sm9RQ3FpQTJG?=
 =?utf-8?B?Q3FEdG5QZ3FZb2JTZFByZnY1eDNQdTE4LzhaQWFSVHVXWFl2SVczOEFyNi8x?=
 =?utf-8?B?cldWQ0lLZnVOd0hOUVV3dmQzSm5RYUdMbEZDUlpNaVNGdWtmdFN3ajJNZC9r?=
 =?utf-8?B?WlZVRDE3ZGwxRGtTeFJEbndWVXgxUlZzRjY3R3V0TitwcFV4c24rY1QzbUdD?=
 =?utf-8?Q?KpMJgKVOl32Iyb3WX/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd677acd-a8d1-4422-2a86-08ded912585e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:49:55.1674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zl2uEAYgcUfIirjTK76nsQc8/DFuBCl6MR4O7i+it92NviStxEaMiuy4MTPeaCU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

On Fri Jul 3, 2026 at 8:31 AM EDT, Brendan Jackman wrote:
> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the latter allows you to pass NUMA_NO_NODE.
>
> The former is going away and the latter works fine here so switch over.
>
> No functional change intended.
>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Assisted-by: Gemini:unknown-version
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

