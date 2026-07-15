Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0C443E3F
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139147; cv=fail; b=VdmiHo5GfyvDUsh1e9KCbLeYCxPop5ulTSv5Sn+yho5uquO3HbOzBoyZ07ZcPLbtoybl2Y9dZIEv6iUaykpLo92gaKGnOMj2OSp6qMki7aO5hizKMSxrM6mHMQXHsnoMcfZNn9bqDBcpJiOB736aZUoxYJDe8nBt7hkjVLFzFSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139147; c=relaxed/simple;
	bh=AgEyLypCp7OW9+c8NV+KQa7FrEhLsz8GRvdjnEhVO48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qEJIa/qEyLBY/FlyOjNLBZw6q/d4dV1kOdxUmjIu4k3XK0XnYPoN213Px3Ctufp6+96MC0Qduqo4dlzILFRZNhbcHjkvNMdjuoKTXeD6aDZvJiTZruFwyA0PQF7EVRnMRmmlBnR5gD1yFLzByrS3slqk8+eoI9IUkPAaO3a0w8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CqzNLaCi; arc=fail smtp.client-ip=40.107.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CqzNLaCi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ih1zYar3SW0wtw1DRZM+ET4JP1cjCLah19s+1k7Hyy8AYRb5nwCEik86qxcs212ub478ljpSYumlwi1Bt4IBBZkROHluHvtkfcihZdz0qEkQdUzGHEIHDVgYIMJ3qYaq1ZugQM2iNLKveAkX5vnPXyuq12tA2RG9NuccBij6kvVW65b1zqzPluLlxO30JJqbHstqXafbvKv+ojUjIH+sJHxyWvNKa7ADW37P2uS2tFU9voY795j7wpYinbHRaO3aEaYVbZxKvDT7Cgx0oU1GawkMhqKRBQmhvmSc5rYMypiY77BQTuiTKYz5w/Qrl1E0OQJ5g1+aoHP4REooZS7MLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8361qh7hDBrLqCgGqE2X3Md1zcMIbtWzrPuk7vY6SQ=;
 b=j/p/+FSyWVpjMqgw36fszEJcbMRlwK7GsRVJRPxtu7VmgQ4+otxZ9/QGk7VAXkPg5xOMwxr9M9mhgquLwR8d5CLabxOB4Si20ZWteF+KawnEGi85sso+Cwm3PsbgpT66qnw56icVpfVYXoYC9udHThij997ASNDSIq+LUJ2u9y2jzmRzqyr+1v4bHGjv70PZBQmm5fbj+fv+nVlEHoE7ZvhydIFWynI6t7RjE48I3UcFJjhBqfDF4R3lJfgFn7ZPg0DGnL99ZapWXcV4/i4C4zhViRr6WfwLXf4/qz39PEWYtDcvAEH7r07MuoEvQVR4YpSkQrLVcUIf7O7CSgYFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8361qh7hDBrLqCgGqE2X3Md1zcMIbtWzrPuk7vY6SQ=;
 b=CqzNLaCi8qWLTyzyYL8OaCILPekPMnkredn6Gv9z+h1gwHMt+8gXxUyjypzPGSBW6YJnigzdX4i0Yxbo49BKdkF/vI7SHQi9OxFSInwF/7zfjT0dcl47kDjaDf5TDBhswVjiu7FxV1ivAtF5+q0pZ+lcIrivT3N8nLou1J6gSLLIb5gbCnFTL7x5cWD+3DKxRk8QUZdMeLotMjwUNrXAUe6My//ZuMOXzWmtELSWLo6JK6rprrEn+wVVtULl6krwlHw2ShLgoTJ2hdARR9ME00dtmw8joUcFnkJ6uJ6Lwh21Gjcz6EUh5XKdqDazzgiRcW0Z8FdWwggSfzmCpgFh9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 18:12:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 18:12:21 +0000
Date: Wed, 15 Jul 2026 15:12:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Aaron Lewis <aaronlewis@google.com>, kvm@vger.kernel.org,
	alex@shazbot.org
Subject: Re: [PATCH 1/2] vfio/type1: Periodically try rescheduling when
 unmapping
Message-ID: <20260715181220.GF3775915@nvidia.com>
References: <20260714210303.3967981-1-aaronlewis@google.com>
 <20260714210303.3967981-2-aaronlewis@google.com>
 <CALzav=ckyqekeXkhzyBc9tOEU-_Ukmgh30dcye-BWbaMnNa6vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=ckyqekeXkhzyBc9tOEU-_Ukmgh30dcye-BWbaMnNa6vw@mail.gmail.com>
X-ClientProxiedBy: MN2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:236::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b5369a-ee87-4025-90a1-08dee29c9d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3zY6j/KwcIbNpEIGipiYZM1rZaCKxGdf5S6h03Kc+AnG/yw4AI65ke3LycZt1IJ14Nu6Ts4qY8HueczuKjlScZ5IfFsvAT58HfYfB5LesCjbZusL5uu3f3xo+2hVbKVRXA1i6Zxu+eGlXDBGc3VbVS9mCUCPLWIcKlgubFA4R3tdcQjGGZLTIgSszzahPu8/NZDgl6IVyS5Up9aLmVYJPEZ8tBjtC+tN6HQheciBjmYMCedwDCCKdXlTseUvyAjOxSjnn3Zx+UygNYFCom3fCQKTynRe8aNd0rgURDyM0LtJT619ndxv5ETeo5vqzqRYI/txnuHdMQYxAyB/szXTMVf+A1cMRw/Tk8d2jPNO5oDER2Ela7lfJ1LimoFTQlqSqO0hKiD8fbKpAYdK1zePF/1czyyiUFu99FHOiVqmX4gtEYt/tn+tmvdTAwF0G+dN16T0hjmLDjibHJMTY8pfA8QUmt+WzNTZJ1R1VQAtcIfeIDIEIZ9tr6uKH026W0geSKIajwhhcrGpvmMLX2Pqsr0Yopz7O5lJtHRHi1Zbk908rDGOFDaz2Wo4dEqaS/zP+3sQ9ak4fVZthgW82B46O0r5p06dmkeeIBCj1jxDrDltnO537KlYxPTdJSY03RbEEAuGofBHELgp/NU7Tg8FZA6h7kz6UVngPoCgbOuMcN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qi9LRGpRL0c1MzBUOWx3eXh3bFhpdFhoZDVUVVhSenF5U0xJWkl3RjhaYk1l?=
 =?utf-8?B?cGlSQnQ2QnBDb0VXTTYySldxSmlvK3NwR1FYRTJTRW1VQXhIZk1GYTVac0tL?=
 =?utf-8?B?bWZIK0pWSDdFaUc5YUYyWE5XSVJOczYwZDdTYUlTdzJuWjhHeWNzQXFtMm1w?=
 =?utf-8?B?Mnp5WmhzWGZIdy8vTE1OMWVrUS8zSXFLeXkrTVlEWXdYWDNBZHhsd0dacmhv?=
 =?utf-8?B?WnMyY3g1aTVHVEdKU0VRRDQwdHJoNGFEZCtvTVVRM240eXQrc3lza0NUZ2tP?=
 =?utf-8?B?elNPUHZEUFliZlQ0V21FbDJuMytsS05aaWpvWXIvT1hIZlNmRzRVQXo2VGVP?=
 =?utf-8?B?dTZTOXFYZHg1TU40U1pLbytqT01maXE1RzFTZjhQQi9LSU9RSzhycGdSd1BL?=
 =?utf-8?B?Nk5jc1hiMzAvNkwrZk03OGxFYUxCS0N3b1hWeGJTbVpqUHFodXFHNEZFc0Rr?=
 =?utf-8?B?UDNJNENWUkNENGVIVUt2VUozcXFPaDVqQk9mNG1CR3VONEUwWTlqRU9NLy9H?=
 =?utf-8?B?VFptaTJIa08zNnF4WmtmbWFDcXNMZmhScDJYS1RKUitvOFlhTkJJRmVqV1Yr?=
 =?utf-8?B?SFA3eEFMd3B0d2UvZnlZRTdqS2xQOWhNRkI3T0Q1UlB1cm5SakJoZ00ybXM3?=
 =?utf-8?B?b0JIUmRBc25QMDRGVnhsQnlnV09sQnlCL3hzSHlmU1RTdllOSG5PSERHQWlX?=
 =?utf-8?B?K3d0dTVQOGtvN3lScGFDaWZUQ1JTTWVBSXRkSTlhY1VFeThRMEt3MmMwdlNQ?=
 =?utf-8?B?eFpDMGl6UTFDS21YZEZZME1VS3VmVFR5Zk1yTStXUWp3dzdma044ZkZkMDhG?=
 =?utf-8?B?SzR6dkRxN1N2U0VUMkszUmFGWFh6bHNadit6dndMVjI5QWNMSVNuTk5sQ1Zp?=
 =?utf-8?B?S3ptcjYvWm5NR3cwRkJKVXRlUE5KY1RGOHJXRUw2aHphNDUrQlpXZlRJc2Zm?=
 =?utf-8?B?aVlyUTZ4RGdScjNXeVFGSUJqUGtwc25IU2h3SHFlWU5MczBrYXBvNUF2QjZy?=
 =?utf-8?B?V3Y1UnI1d0g5TUZydHYxM0FGaldGZDZtYnJhL3doSU0rekViMW95RHVKNEZO?=
 =?utf-8?B?bkJWcitkMk5iM3BvSVBsVkxHcUlwWE5RTzNseG51cFoyN2IrZlpnUTBVNXNW?=
 =?utf-8?B?cFBQMldZZjdKT1o3V0k5Rlc1bDFPaUtXQnNoYmR5TlNrU2lhQ2ptUTRab282?=
 =?utf-8?B?Z1ByYnN5RUNyMTlrTXMrRkxuUGt4SXBsRmtSZWJlRGhYVDlQUzdMUGJzN1hN?=
 =?utf-8?B?NXlhaWc5Nm9INFRRbDRoYzB6OExVR0xGdHpxRVJmM3RnWmh4eWFncXUyQThi?=
 =?utf-8?B?VjBGUjdVV3ZQK25UR3NyRnBjU0tmVEVvZ2U1R0ZSWnM5Z3JUU24yQXZ0YmEw?=
 =?utf-8?B?UjM1Um9LaFFrRVhpcEpJUStvbXN4eDZrNWk3TTJUc2VQTVdqdjRLanAyVXRZ?=
 =?utf-8?B?ZS9BTDBVN043OWNOaGR6UUxpei9HVG1aSHoxRkNjRmhUaVBjbVo4VXlhNXd4?=
 =?utf-8?B?bklDbUtsUDZFZDlreldWRGxucmJ0a3FmUmVSZXI3bW9CN1NvZkl2NTVNNy81?=
 =?utf-8?B?OUozZHk0K1pQbU9PNzUzKy92bXhYbDZ4b0tsOGFhZGVucnpuSXZIZ0RTTDR1?=
 =?utf-8?B?QUxJRnpqYnllaUZFOU9nenNSbTYxQ0VYUmtWZUF0MjlUeUtKMG1mYk1FOXdX?=
 =?utf-8?B?cHNZSGhDNTYwZXFnNUtRWjhlN2NOdGsvZUJRa1BMQXZUOC90MzRSZjgzUWwr?=
 =?utf-8?B?c1MzcWNlY0pXdTMvWWNHZzRZQWVPM3NwbWFKZy8vTURQMUJsRlY2NG1UeDBQ?=
 =?utf-8?B?QURtNjh6UXBGa1IvSnJQb3haYWdybG03b1o3c1dWTklzay81cUVON2VQYkl6?=
 =?utf-8?B?SE1tbWRCQmdUdUZobWs1Z3hjL0hkRkpRbnErNXd6NDA2TFpoazBrdHl2YkNo?=
 =?utf-8?B?ZjZnTlVOcm5QeUVGZHcxZ082WlNmb2NabmFmUzB1L0QrRjNwZ2g1UktEdHBu?=
 =?utf-8?B?aTh3azZid0xDamwxM1BFVENJclFUOXNNNStnSmJ4ajhXcjNwelpCWDBSV1I1?=
 =?utf-8?B?OEtwZ1JTRW9udFM3UG1xVjVITFRodUg3ZWVDWThvRmVGaVBzOFRLTjJkNXcz?=
 =?utf-8?B?bm1XbE1QNVBWWEhHWjcxMUtBTnBFNElOR0plZ2tKWVZ4VTcvbEx0b0Q1TWZE?=
 =?utf-8?B?UFI4c3JtcEVhMXFkYjBUeFlBVGQvZ2UvalRRMTMwWUM5N3RaUXNtd0pXV0pF?=
 =?utf-8?B?TFM0ZEhUWkdvUXdHdmhsVDZqSnBGVnNXMDE5emtFaklXQ29lYldsa0RqRWZz?=
 =?utf-8?Q?26PDIYa0vxV6BoNUCD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b5369a-ee87-4025-90a1-08dee29c9d5e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:12:21.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhfzFkdErEdeOFa/RitUw0pSfYagoiShRDaAMV6IzVhaqGIGjEuAe7JVjcIw1zBh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

On Wed, Jul 15, 2026 at 10:39:01AM -0700, David Matlack wrote:
> On Tue, Jul 14, 2026 at 2:03 PM Aaron Lewis <aaronlewis@google.com> wrote:
> 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index c8151ba54de3..e78bc07d9b6e 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -1153,6 +1153,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >         int unmapped_region_cnt = 0;
> >         long unlocked = 0;
> >         size_t pos = 0;
> > +       int i = 0;
> >
> >         if (!dma->size)
> >                 return 0;
> > @@ -1196,6 +1197,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >                         next = iommu_iova_to_phys(domain->domain, iova + len);
> >                         if (next != phys + len)
> >                                 break;
> > +                       if ((++i % BIT(PUD_ORDER)) == 0)
> > +                               cond_resched();
> >                 }
> 
> What is the performance impact on unmap if cond_resched() is called on
> every iteration of the loop? It would be nice to not have a magic
> heuristic (which is brittle as Sashiko points out).

Calling every loop is definately not a good idea.. Some magic number
is a pretty typical pattern for these CPU bound loops.

Jason
