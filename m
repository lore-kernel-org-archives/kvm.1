Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3323FADF9;
	Wed, 29 Apr 2026 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466794; cv=fail; b=CelX+QSa6S6zgL8gNaBxNMdSMLbM1VOmNCDcYPD5Q6IjnWdMXPS22HcP4d4xO+aStnAiRz4gV2imX0zBbUiexsW+eXyAZRaSS4hwT+8vZXimPkktAVDWyXY8tofXxSFUHRuuOlaD6jCZy2+mWRAIinGsARQjMXSKBK5r+w7NONM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466794; c=relaxed/simple;
	bh=pijKg+IxZnZlZxRCh0d0h5eBOMrkIU98SyYt4wof3xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Govs4QpmSOu0VMXkrF6SCjEqHvDzJwArdiYXeMcFY2E8h2oXxXj2CXC7BPkNydkx9ZRSg/BgUkdCiltsgX8khT33jpD6SKeB46IFSJHjshIAzqm4RF+z66QOkFii82Lm0TZJrUDgPMqh9rdg6EPe+Ti3wfhT3esLMDGz8MCujpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWyPjC4Z; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWyPjC4Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3HN4NMEcqxG/h67HQas8om4bDfHxT9cIGHCokOZcrjXx3i+U6+LwvRO+IaO7HU9E2tpxGf3opz81wTdlRe1sa0OrEgCz1b+397HpKqr6+UOW+mA/JO8uAHfnLyH5t4KQo3SjrExtWV1TsbD7z3bN5G9gcpCq/SbQxmKnKBa6p+svNmzTLPGaJoMe1PqPMvvms8U86Vksj24gZr8nMNOSY+nLNateF3LIgBbdDog149UBBENc8Ke3hwskGXfEb7h5mwRZSFJICt6RwjRdBnXl6H8iuHHGoPX6sURUXR8Jj/zBNF0/G6Yh2YwLQbfdROqwC3+JyVUO+gTnAj4xerWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM5x1P+eocJ60aLUumO2MzvSRRMshGpQUUnkVjtC0Rc=;
 b=ISzbh1xQFDMmrGQ1k4QzMP4exd/eX+54E1AMV8sUboG0YQ16+1I9P/3rCTOIhb26eilF9/s88KAK3/RRdU83UoflhnapuAf2KTcaa/WnPqgup8BYQPrO5rWn4sb+MYp26mixFZS/+2MLvUggwW3HODePe6traYUdHn7vAtjb23hRZWmuQtlCR1KOoyA1ovfoeSz4731eSNcOKUZ/t4Aw0BOgM8OY9GztO3OHnH6LJ8CKJenmB7WcK02nmpTBGsP5Brx6qhbIK1Jz8Ci++JluNcih/8kYmDDPxL2icQwIY+klFW0bSjPShT7cDwOXN9nH1bDFZYN6iZ9US3v+rlln2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM5x1P+eocJ60aLUumO2MzvSRRMshGpQUUnkVjtC0Rc=;
 b=kWyPjC4Z10lroisi2G33bg8rQq5efJ9YmS6xjSluspgw0B/N593hG+ge2IMIOlve2CxpkoH6H9VseqLackT73DFxwFb9oQLQdBl/oR7Fgy7bEZLxvSAzhpk187MrsmxI7i+ES+OleXS2SKEl8zt7OGtM34Q192LEC4+IfBm3cKhMcI106JtbJjf2A1+bVbx68sX7foK5T5vecuW6gfIQw10fUajDpd4qJAHTg1u4NHepDtiUe/GkeF+7z66iNUe3zDQDtL1mfZ67DAL9sVq8g5vNDKlk6Lj0tZinAg4cqk9857aJus9Jq/9HQID6u14pCemdtZ6cdBMENVcmQS8UqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 12:46:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 12:46:25 +0000
Date: Wed, 29 Apr 2026 09:46:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Ted Logan <tedlogan@fb.com>
Subject: Re: [PATCH] vfio: selftests: Allow builds when ARCH=x86
Message-ID: <20260429124623.GC3225388@nvidia.com>
References: <20260428232707.2139059-1-dmatlack@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428232707.2139059-1-dmatlack@google.com>
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 99808102-0864-4777-9703-08dea5ed5346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	woRGdhl+5Tq20i+CUc9sdeZSYpxSIUgVaqod6js38ncaShZKj/BIMZKA3rXjyc0EOfUTLiFA9UWbRGC8w7mDd+J2Ff4QTavNefvLueGkTnrFnro/ur4zr+owy80wlvZCTUBPYrDGZKspg35pHLnf/2owBiGUvj6iT8WZdFjW8taWISLH+QeB84XRjby9yDzaYQ+80xlIisFcCnK5JxZsQelx1QpGHKcJPZJ4LmlPP/ZQF66yEQZ5IWOtHT143rOEVQiNPLJ+k0HX+N7lMqZoJKNK5+0kOPfWF6a8O02rsL9FNPA3vQunxiK4cMTUcyFW7NXXq5xm3ZQNMmKtL8i4s8AB6XijbxSkPPXq1dmsurlBO5ju0F/iGITuSdolPF/mKn0PmPP9IiSTrnDVPeolNw6I1jNm6jpcXmC/GKMINw1YCIeXY6YXjdfqDH6pu/8COGnp4TJHZl+SBidH5FHWR6AKwMej6p8KGV9EecZz9Ykw+n5UdxDP0dUO2BvX4iWFntJqydPhqmXdJ6GjuFqCweHvHPF9D7lGyMIRcOC6HOrJCVJuvnjqkal17UhsmKKPc99y7PSwwTSWlGdwUUwBYa/XNvMTjhxHdjQGtO88VPlgRo1KrYTagt5U7PD+WU7E0ARfr4xnzAOUlc42xrarZe0ZuNQskvOY3crcqqPT8podOkNq16+0x3VFGBs5n+Do21NEa8jf4Ln+HlwOUde/2rsXS8mzZX/DMKv1Cx6ppbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qIhOXXJzgdR9OP1OWayuv9yfkTlDS8XnTKzeCszHpPYcRJ2s708YmHOknTcM?=
 =?us-ascii?Q?x9Z4+wRj1zoo6EqRp0piS08uVFFtWVYJP/t099tIDBP4NqDoj409D1Fp1EIq?=
 =?us-ascii?Q?3rGleDEU7IIAcIdP8qO42RVWqQ/SVIjBkvB7w7zbX/5A9iSKe+wwbN5jUl2S?=
 =?us-ascii?Q?HLa5d9zX/EuYLzAYjuxNmVf3w8LRCzt79ZxUuIHM5U3BxEqoNKXBh37AjXBd?=
 =?us-ascii?Q?I7eurO+NwDUtDM0abwgsPwvt/rMUuN4G/MjwAwDzWmOilhnHdLHTmVCwx37o?=
 =?us-ascii?Q?sfIBbxJHHhXyhZkJYjl+6a3olWhiEXI6SgVqIMQ0IOQGR5X/yqhJQNKPKtS8?=
 =?us-ascii?Q?Wd+dHkYZTYtThNBwkzaIYfKwehRJklCbB69cwH+29QbBe+rYgzthXG0aszYD?=
 =?us-ascii?Q?64qasU8ffF3QWUs4eEay9uG9IgoKTD4NfCcGjCk4eWLuoX5gUWRTubYeyAyv?=
 =?us-ascii?Q?5igWLK6hvW0p4c3VogX3a4Ho5ZLQxAdDUZo8sQST4JpSDpWX18WoyoN+Rxr8?=
 =?us-ascii?Q?W53jrqSfuCQ+Hcs74bD3t6znHHPGNOBLyR6jb2d7KUFM7hiNXWbJSUHLHsu4?=
 =?us-ascii?Q?nHgUBLf6MqSfnpBGlcF4ga74Dphz77+nMToWZGcc7op1lSsziwmnIx7W6rbR?=
 =?us-ascii?Q?t3CVFJcL47mqiNYNbnO662FFvIk0FTmr+gvIrNktZjohE+pCHm04HtAJloRB?=
 =?us-ascii?Q?kMvWOyPCkJZqlIeFHWTMehqGlyVrqOU0SRCxojmzq7LaygNsLQXgC3wFnPCD?=
 =?us-ascii?Q?KzlgqcZlTbjh2r5z4lktZoBwSXhuR800VjK22Ceh0x5bUa3Leqwp+MSMafJ5?=
 =?us-ascii?Q?MJccy7Bao+rL2AWmZPAc9x/3WS7IQvjg+0d7OQaAeV78Cdi3wARBSXzD7Kvo?=
 =?us-ascii?Q?2bjn40hzh9iXuauCwRF6XiLlY82+/cR9v/IympNyQMPLTcYGAwdhP4bGs4xb?=
 =?us-ascii?Q?v+IOWcSJ2nIYj2uhkYuJV+EIw7vA6tph9S4H6W+M9sgjiBOUToNDFAH0Sklm?=
 =?us-ascii?Q?F2i+XNc3mv6GTcE7dIsTqF/ueyEglEKPrfk7vG0iif3D/IZV3aLFpdjQ8KVU?=
 =?us-ascii?Q?u+fK5G3/y7lAFTgs8b17IAKFff5sUhyo5CRwcEPY/phz6+5j4+LMQDX5DLqC?=
 =?us-ascii?Q?4TlJyhSIphvLt6V1azG1t1NUUnBEASs/7F3e3Vz6B3gKYNdP7gXOz+ySAr7C?=
 =?us-ascii?Q?+hN5kSvVoxnr38cpGo+G8h4iajqgb+b8UZ4/ahgZ/Ro4pzLxcPtYluTmddd2?=
 =?us-ascii?Q?e0VnVyFlxTgbJLcryDz3P9K81xBRL+kJ7hxAdJMQMGjY/znVan8BIWiGrLoD?=
 =?us-ascii?Q?LxrNcrZQTvggowN73L6BqYHmGnVk/O1Nd3qlByBTZMbxa3b286EFNj5/PTcl?=
 =?us-ascii?Q?zUbH6wtGNJyU3FJSPulnqIZEsYXVi8sTwZjabVyPrh78dAdKCOAAHjyT7a3k?=
 =?us-ascii?Q?3+d8jLcK7kdMxrxWXbPG5HmzbVv3jvadi7OToX+gYsizx7L56xF/8nTrF0Tu?=
 =?us-ascii?Q?YK4L4wQtFjFzWRKxNTF2mfQC5xO3MgmtKsC9tVgh/aLRFDlCr3KFp1RW8iNw?=
 =?us-ascii?Q?22jiu8/mA30sVTGLYaviLSUeWIMEcpxOi6v0rlgDLXZc6mdkfr+o6YsE4Zbj?=
 =?us-ascii?Q?WMeOhDqGtJ12rLk2X1sVOq6htwdg+aTEd5D5kBuADubsxCSb8UhkgdJOeYkP?=
 =?us-ascii?Q?V36pIprSj63jRudg48cpuoDskinldjzHOVOVAikWaBjOLc3A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99808102-0864-4777-9703-08dea5ed5346
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 12:46:25.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrtxRQX9i22ZirSvcROEC4mQuPSBG7zlivCT6waDb7lLeBKQ7PPs48sbJyQhJVYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471

On Tue, Apr 28, 2026 at 11:27:06PM +0000, David Matlack wrote:
> Allow builds when ARCH=x86 since the top-level Makefile can set ARCH=x86
> even for 64-bit x86 builds.
> 
> Note that ARCH=x86 could also indicate a native build on a 32-bit x86
> host. However, it doesn't seem like anyone is building selftests
> natively on 32-bit x86 hosts these days since KVM selftests allow
> ARCH=x86 and fail to compile on 32-bit x86.
> 
> If someone reports an issue on 32-bit native builds we can harden the
> KVM and VFIO selftests to explicitly check 64-bit (see the discussion in
> the Closes link below).
> 
> Fixes: a55d4bbbe644 ("vfio: selftests: only build tests on arm64 and x86_64")
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Closes: https://lore.kernel.org/kvm/20260427231217.GA1670652@nvidia.com/
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
> Cc: Sean Christopherson <seanjc@google.com>
> 
>  tools/testing/selftests/vfio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
