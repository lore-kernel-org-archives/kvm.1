Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8233EAC98
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858617; cv=fail; b=ms4kn2ik1Tdpm6YG1HkjaxP2LHkcIB/pJO6b67rdyHzMOyBesV7T2UrDAJrzsdZGCDtCCPya/120LTjuzrXgir7eBesF2ct3a2tfEMff95SmtYRCe1FXvHHaB/0RwZjE4afylbPFozp/Cr3LhfF5CQkwRZlSWY9+Rhxgj8CkgZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858617; c=relaxed/simple;
	bh=5c8Y9RptEin3/Ft+esR/m79L1aPKYO6mVDux901cSBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=biR7BJNXPpGGiWq+54MDCXxBaANGLVgMztCdC59LaGOtFK2kyMrYDfNVq6/Z7HjcnpqApPCdjK7JbcSkPhg0ABUsShxK6gWzDB3GBV0dX0nFDesnhkWg8TqwxrmRhOlJ/O7o6MmhrKcHalUpsuMgcmnMMqSPpgoUN5gryjc0blI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tb/AyxkF; arc=fail smtp.client-ip=52.101.61.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tb/AyxkF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vb2cPjASMILiB68BlXBd4NrwoMRzEYgy1QNtygZeZSkEIfI955kBNQZ1g6SqBKyV34b11TCxifVAsOAP41EHQcuNboyHUiifKTaABaUgEkG/kpX7M7Yh80ntuyFB6wjRJwALlqLg1ncf3tMTgIhZ3dkjBRmo6tylKRiJzDlV4R99x0tdcFqvXIU357SzLtavoS2qMQEIYsfGcM1dTvXOHO4+YtN/BbqK1W1qQztZO+g3ajZSuOPLYBIL3kdpkFBTiJ9r4Zdh9f4xn9VtJtNfEQYjS8xxMdk47eS7NQy1VvEN+azPhM7T3OzqfBE/4P1XTnnCWZU/LjuYY0RscG4E5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkFpRnyhE/AsosZoIxdVn3x8BfnpVUNnt1uG706g55g=;
 b=uu8Oto8ztM+bCkYn3Z2fATNnJ4OghJ9HtcH1+IxRKblWH6MPUtG/VdDFmvaOLx6270fdCBhcfI0NbOX81Dl0w7ZrvW7nZ+heJ9myjdVlDEWcUHpefVsi+32DynQlHUNIhH96OCCpkSYv8HNrVNucHM7EOmB5JrnO4nYT8UaP5rEUOu5AWtsYOsbj7SBIWPbbevqAgFtxUlEwolRYrRpQbGnxjOBEDyI18EA8S1+krPwXqRt0GnOZzW0OpDoE/gG61r4vpogH+zA4USqkjCdfmGFGCdmr+rNpshEpgYUf2DbDAbo7LWeayb14B8ToHOMTAzocwm39SH0mWTx3wRDkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkFpRnyhE/AsosZoIxdVn3x8BfnpVUNnt1uG706g55g=;
 b=Tb/AyxkFjy+Zvefc5WCJu3iJFswE6ttgWEKJYUQYPCXEp+waytHRZmvOZTPc3M1OmWoZyUTWzVXQv0syQ8vG3myvY5SsqoJ39nrIqdUiXV4rBhT+V+C0NBUi8WqFW2pcsPXGSQZgy4DB2LFGM/fO2vfIYo0B05o07sikY41a+47q2YxPxUeiX021Kx5cCNLy3/M+W25PbylAkjspi5GhSlaakS4clFt2gJZ5IkaIerlnWbZue8M3iDbWXIZwumOnrxlshvDWR/u7d1RXNA2d1Yq5thX5L2K6HcXd7qVE31CgTMqst7wKCZ/MsNoliW6uHP6r2RRw/YIVf2aoavEEeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 15:50:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Tue, 4 Aug 2026
 15:50:08 +0000
Date: Tue, 4 Aug 2026 12:50:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, dmatlack@google.com
Subject: Re: [PATCH 0/2] vfio/iommufd: Prevent scheduler warnings when
 unmapping large regions
Message-ID: <20260804155006.GF27883@nvidia.com>
References: <20260714210303.3967981-1-aaronlewis@google.com>
 <20260715181133.GE3775915@nvidia.com>
 <CAAAPnDHkJabsf7haMLX7bp30qxcbXc_81y8mw5t-3bNWdm4LmQ@mail.gmail.com>
 <20260716132019.GM3775915@nvidia.com>
 <CAAAPnDFY82jgEpjw_R7tZ8m6y1XdBZZOOkT=6B+yytyYsYZL=A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAAPnDFY82jgEpjw_R7tZ8m6y1XdBZZOOkT=6B+yytyYsYZL=A@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0630.namprd03.prod.outlook.com
 (2603:10b6:408:106::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d98d7dc-c19b-4797-cdb4-08def2400f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	HSR8qVwGGj+Da0PdGxx9INk0T3juY/0RBEvkwPfJuNU2WokyM1Jv+wNtV0UROofeA6T9yaciCCg3ayzsT+jaS1onA6dZCygEO2/YcQ0GMkS8n51vuStDciLYvt1nu/2Im0zPImL4h8keTeJlSkSFTJtecQdoW+9yyZUdqNlzyjD02vjuR1neB7coAoe17BWcPh1+59uQou9rskp52gE9iB6vGj/AoJvT7jDEc1voSnQFsAndWCQpfmdM+C+MoWtnZbcfGzH365w5blcRvyK41htuw+gnMoLMlU9q8LHhSN9gKClb+ckT9qrSgLbF3WKa8+2W70K6e7fTbM3e9ixuViiwqJGfbyW2r5RMPt8eNKaldpJu5lwO7fNFutrVufvI4oQbM9sH2/SLdyOtgcDQv9oYd1aOUAydLMANg1ZNHzONBXmcDozMLhM/8k/Lyq/D9mHGiFyNBhQJofj0FpnK8ttSGdvEe1pJrPDf+MFWfdt4+Cl00hNcddY2pq0NIXkvX6sPJCelZ7bFOnAq9y3iu7xIsLDWOG31+jh2LoCBM0PtFvOszpZun48ag10lTgRkgKJBt7MS1agSIF8BKlsAyo2TnvzKTh6r6WKVPQzFSohdEe+kpF1y1cD9ftTTJ/9TRWFfFui0kd235iEZmI8a1Soe9VMkIWz8WZjm2QxtTSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E5kHULYcP3lz3xkHtbAN29pKhudj4gP0PlJ0VD8d7pyzhCFNNLMp0IjEcIr4?=
 =?us-ascii?Q?3cY3KXtomi2ce6gDOeC6xvfMT7uvQHmrtMygj7TSbS2p74Ct/Gny/GOBOiSO?=
 =?us-ascii?Q?lkwluurwtselEaP/lFhNZ9QKB7Uc9P2eK1KGltNwQzjiv0d5kueQfuoUrt2y?=
 =?us-ascii?Q?Q1vWxegoqF2bR7EpvwNE0C9tWBpHhcyXl/T0iXixENtI9hoV76h/8Hd0V43e?=
 =?us-ascii?Q?0CaQ8LoTvEqh1GSu6KxiG5qQYSPgx5UdBgQVyYiQYY+nIsUdnBdtzCvksdnS?=
 =?us-ascii?Q?pgi9yMWnlmofyGYAHXeU2ZGRA+HnUlPUQ91RQcCX+lRVrxf1Lz8gDMpXYg1L?=
 =?us-ascii?Q?hjUN9GAVM2IKdBf2LgcuficEQDHWIqbJ40shfPMLrZ0gQUHRJM/VlxDZ/+I+?=
 =?us-ascii?Q?1UFkztdnWkKtwow77/XzGxHRB7XGxs8CEJ47i5x5O0O8fpPpk3UzbxpVo2kG?=
 =?us-ascii?Q?rjMrRJsaIpYDyREBDZbYWeQQngFJoUHmgJjUz+/VWoMw63Uud/GCoTC2qwB5?=
 =?us-ascii?Q?Q1koXH+C9kMEUyayPb0WecKuvMh6K39Ee+WoWkgpn/3PvOiYNbAPkhoMhniV?=
 =?us-ascii?Q?pZDvfzb62nELxZ4ano5lsc8rFKrX2bpWkgx9FqUu+dZA5TYIqdhCNrOAaMxQ?=
 =?us-ascii?Q?TcalQriNeLJcSZnT3C/JR8xQkKOYRnyD/kbatVOy/FntCwlNtxZW7iSefxDQ?=
 =?us-ascii?Q?PnVubH4ggjhJW1lkCn2+TxR2kduOrba9/f2cEJrkkc912UPCIzEcpE0jnCtx?=
 =?us-ascii?Q?XVDBIRaohy58HPEcgz9jVr8jfcY3Pd5KwxkjQ8PPzecukBekzCfhOj2hsUki?=
 =?us-ascii?Q?CwvEyezRCMuX+hxk/mhJaRx6uzJvc5clXIr5VlTpkmTxyDbGPwbUalVw/RPi?=
 =?us-ascii?Q?uLd//gwWpWwypuFpYC60GI4eA3G5liRjstYeN4DlZgozANLPUhhC8R7nfcYK?=
 =?us-ascii?Q?JvJcwvwj5QSZDMVER/LLQ64tko4d82rVBLvDfWcU4iwwxLzwYBwkDsrubgze?=
 =?us-ascii?Q?+BISqU8awZ7dV5Z8QkYJa9aGMIqizh19Wr7CjvE2vmWjTnDcFsBOopmgls1A?=
 =?us-ascii?Q?7lP9+nqQg09Ouruyj9BqdUfPA6kqeyKdxYEpGZ56+QUpqikXheOWzTy+I+F0?=
 =?us-ascii?Q?Yg+H6KwHgA3iwZ2gSLBKmKtUVGaT48iIQ4zLNH08GtEWu00pmUwjhJKS3EFP?=
 =?us-ascii?Q?ByoUCNSVkKQBkZnxR328iAaB3tTAvlWQBrioXGSXM+ss4adh924TkKqC2Tki?=
 =?us-ascii?Q?4UYbchtEG4mM+BOPWt1M/MkLypZ6AQcBhOIF6bPt5V6w/CmiyT2YE8CPB9MM?=
 =?us-ascii?Q?+Kgf62jcxlbbWBUQTZPlQFKWESjeK1dahpNEsu9JGKSc1BYWho4dCLqTJhVp?=
 =?us-ascii?Q?DlifFd1V/cNlcHvE82yJuRNFTRR15peeEKkDYAiV87dSLCJWHRjuXCVEbfC3?=
 =?us-ascii?Q?xfLFsWEhORnShBbE/E7dVIT3UilNVRAloBYuN0nakm76kvOMKIRkGigDyhDQ?=
 =?us-ascii?Q?d4C62YPnKC4dENCrWFqiRT6beQA0zh+zVQz0zj6xatl/qtnWfcpLPReti1JH?=
 =?us-ascii?Q?/A3hx4SCKCAkR+YHwEd/e/lKjEKjrP7pHOivWRFo4tK1PWVyjS5oEKc7zUxh?=
 =?us-ascii?Q?PPRGbYznqZNZP4dtl9ZdBHvicv8/M6VRMmyzfm2Fo+J7/AR9+HA30+xVR6og?=
 =?us-ascii?Q?txJNsn6ZCUcE8oDjeaAadKdfd14FksVBozW9rnJXUR1pptM4vjfni7Q/6OCX?=
 =?us-ascii?Q?sy4dcpjQbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d98d7dc-c19b-4797-cdb4-08def2400f02
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:50:08.0296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2/vqawx6+LgFlQzG9RRkOxH8NNHJ1NVsMM69hsFeFOO8HHoAsnRrjSvVS7K8lTw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959

On Fri, Jul 31, 2026 at 08:06:26AM -0700, Aaron Lewis wrote:

> > > > Given this is the same issue on both in the some place, I wonder if it
> > > > is better to try to get this series done:
> > > >
> > > > https://lore.kernel.org/linux-iommu/20260603151804.1963871-1-guanghuifeng@linux.alibaba.com/
> > > >
> > > > And put the cond sched inside the iova_to_phys_length() ?
> > > >
> > > > It would be fine to do things in steps, like add the
> > > > iova_to_phys_length() that just does the loops iommufd and vfio have
> > > > today with the additional cond sched inside which isn't such a big
> > > > task.
> > > >
> > > > Jason
> > >
> > > Ah, I think that is really what I wanted, but I proposed a solution to
> > > get feedback quicker.  I'll wait for that series to be merged and
> > > reaccess if a cond_resched() is still needed.  I'll follow up here
> > > once I've had a chance to run these tests again with it included.
> >
> > It seems kind of stalled, so IDK if you want to propose just a bit of
> > it that would be fine too
> >
> > Jason
> 
> Any idea what a minimum proposal would look like?  Looking at the
> series it all looks pretty relevant given the goal would be to have
> iova_to_phys_length() land.

I think if all you did was add the iova_to_phys_length() function in
the core code, implementing it as calling out to the drivers as is
today that would be a fine series

Jason
