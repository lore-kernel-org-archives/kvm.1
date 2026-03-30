Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A09375F73;
	Mon, 30 Mar 2026 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901721; cv=fail; b=Z2ZVHbTQItDs18iGdYmYTofJqBe+ErC+14JHqRnAzzZJKA8Gnfmqkeup99VBJHcbz5bqEoNDCI5vC54PvFZGBOwB7pHcFFe70Ysl5xbFB9c171wHinvli3+pmRQx7rWy8OWm+cvhpoGycUgZylU1dIe+ztPBGLfx2Sw69MxVUUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901721; c=relaxed/simple;
	bh=F8VvRIa61ySn53QN4ryRxPf8ipaP5WOXFvDiRiWytsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHFRpvVubfqtzWHKVb1aNQ2hnB5EsJ3+Uh5+/khnXCyIxecJaRZY6Ag0234Gp8mL8VqXvhfwDiyVFbfDYMKKI/8HnH4cvyOCzXp8H52g+4af3JT3d/daUJVv6nX3o837IWEMfZnsF96IBJ6zOFzU1Px7JF1SGeDy1XqXALsXFnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l+L/EG4M; arc=fail smtp.client-ip=52.101.62.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l+L/EG4M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2Gc4mHbjYpPoBQcnPKCiaCI6vOXZdf/g4TL6A/SeCZhan5e8/fk6yi1MHDpFCumTzYd/Z7a3A3I2FpjoVIe/SKpqU2+YcKouFxfl24aVcNR9OleEl/Nkf41yrWAKk9fBCYRX2kWSf7YRPgCtfbz/KIXHGBkHA50jnarel+XyjXvtUyTK8a1Tyhm0bADI1vjET4JYA3BHjejR6J+tKamz36lXKa/z/EkM5yOsiDaNzrO+xUkR27qwAEz3+n8BDMyni9hK6IKPx3vZM0sarpBLOkvfYl2o2NWI2PLyOTjX3EbFkoiUWErLX15FZGxtwaUCHGFSbcMV84gh1sUzlDU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8VvRIa61ySn53QN4ryRxPf8ipaP5WOXFvDiRiWytsA=;
 b=lavlHhEXtBa5oijpdOTaRnAvDjRjvKzMM70uzOU5hphHPLoUlqWicju0a0LiV5GSC7Zz8VPSFouUkXNepKwkg/RvCOOtnpqRPJDBzeX8oA9sJ215Iq5FWIb/fFoUfkHR5mz4YtHM1+U9nuqiWeGY5P63Gce6T10YUanvvvUERpDsWU1JhMwX3X7kz/z8yKEOpm5bF1DTYWKEuCTTvYXcOSjDeiELU+2bDCY+Gz6MNk6i0MoiI27oVn1R+L0dizpGmxLXTWOtNQjI66JBzCsZ6EHzHh7XobQeWFvVGEWn1lAM0w8YGXVloygUwHm+xemRDgj2Mfl5x6SqsgCvpLM6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8VvRIa61ySn53QN4ryRxPf8ipaP5WOXFvDiRiWytsA=;
 b=l+L/EG4MFNf2fy2+aEbI1w0Jcni90Yf0R0oTv29+RDCsoBfiYXnwYD4CB9b+6n4CGkNeOmVOh7OPa3w7QoZ5fGkFxaq+zFrWFMyU7/llCohR0+lh0kBUeh/88N+KITbVrQajy8pjBG7+r3FGYKIqRye8A+qVwZ/yoPgCfbAXtjncGpyzNI6+kQjo4gQP21FmK7z+dL5FoW8ENtACL/OrchSuNLykexAGaGtleChUIalvx1MccAxzf0QrYrTtNlDdwjHyh9x9hiSc4taXE/T/kL1j6Z1W7VqHoUqgv6lgjIswBlwRWYI896Wk4tUCr30rrayaV5MKdjrorNCjfNg7Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) by BL1PR12MB5706.namprd12.prod.outlook.com
 (2603:10b6:208:385::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 20:15:11 +0000
Received: from SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7]) by SA5PPF80B25317E.namprd12.prod.outlook.com
 ([fe80::e30:d7d3:95f0:78e7%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 20:15:11 +0000
From: Rubin Du <rubind@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 1/2] selftests/vfio: Add NO_SEND_MSI feature flag and MSI helper macros
Date: Mon, 30 Mar 2026 13:15:09 -0700
Message-ID: <20260330201509.598220-1-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <acb-9VOaA6Ld9BdY@google.com>
References: <acb-9VOaA6Ld9BdY@google.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF80B25317E:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 5490674e-12f2-49c9-8197-08de8e990b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NrHlCRSZg7RxT0bNXt5rOxqZeU9TXf/+4uuz60XIhl5H+c7qVmuRfrAEt6aLSUXiT/NztRCbXrYazo6hiZuEURzQTZJbdP8OIC8RuY9N/g7/xmvrMb9GAb5P+qQLcM4LyfCj2DtM68VzGP0k/7VmagsU9D3Aw71UgrLUxwmmgGSvpnG+pf51a6Ul8H9DMrqa7IpJZMH3Hn6SyRzCZuKqoMjZ0TXa/k3TGKWSyfRcbg/hk7+Id9yI6KKvUlWRTu4f/sx8knpsXyM0OM4V2p0RaDZOUi57jkWdIv+BmP3KlQdxannTZmbHjS3VuAZoQltORb2B2JvZFBBSj2swvIXwmuQ6t8Zs4pre4FkLCggi5FE+vXdOEC/MIotq7eP1oLRQII9nOe5ZSet38Il4UeKfeKHF3JWJZ4OQLVag8zBxWiH8wTV0mBV3hIgPsRdx3GmL4Wvdfu4GazX4bQ5vHyRlCCob67UAMLbWoFjNfacqtDqH9oxy6E/0R7dAi7uL54cdbUp+jQYY8l6VTkk84ey7Ff5pdVj2eg1DTMXvf2LWbDjKHUW4enVVdd4tEjkdYoOpqRvnHtP/k4F2UQhaSdfDTe0FD1bxqDfMLmBRnkzqhdid+n1ruWvNL6AynWyQkG8Do8oLSToSXxzIZSftbJQZcD0W22moujOZ4NPXUDSkpjx5nYVVgm8rG24dQFwsDgKO0pj+Qtofye6rxjBOFBINV4e506OL8rRXFVdktEEczgo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF80B25317E.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CqyzwlYun+TN7+QL4r4vZsXA6wUEmzApz02ykSgq24vkXv+44KBS85opJxuE?=
 =?us-ascii?Q?Lvu/EOalEcBmapUye/boLQSLhCCpjDtN1Q2fLdtshdkxHyF/puE2VJt7t/fV?=
 =?us-ascii?Q?GXc8BltRjhnTTy1koqJD6Dzx2D++Dz9/MoILsaVpm5WzRqlBjznWI4auGxUp?=
 =?us-ascii?Q?xfsSYZYM8dcmxs0D4vYglxoB5RQK79EOrUnaJh15S0LuVCwmnRWjpUUMvIe5?=
 =?us-ascii?Q?JuPwjyDFI4uHgRpz4gC4+rrELXPJcDtgB26rij98FRdC84jibFfpPj4iGwwK?=
 =?us-ascii?Q?O1YO9r4ks+49m+pwwN+p0bJuhOikcTxc1qmUDI5XH/O5o/N9cFj/0sqZWiK7?=
 =?us-ascii?Q?WxXkeIZx3ozE2FgzPq/oQmmj9wVmoVCOBRr4JKFeCvfC4Y5G2ZnKwjp7DNWA?=
 =?us-ascii?Q?E9W6xputHn2C/ov+HTJcdA37UQ5DuoV7CTzEDw239et6ndVAKVyeowj/ww+Y?=
 =?us-ascii?Q?bRFI41nVTJ0M8XYizuojDqYFUA13l8wed5sz3pCUkY7dr/JnenoHJsbzV5G/?=
 =?us-ascii?Q?AaGxTi3Vlll5beJTI1AFC1gfDQgU7PXLBcob7P4yOjDj2hmdKv7+vTz2ZXuS?=
 =?us-ascii?Q?Y8T1jIjUnXO/3NPbLX7VvYQ5M562TBjz6necho+YdIt5DEvksVTJ1l6f6w9J?=
 =?us-ascii?Q?51/YENkhmry9/rhCCGJKAywUWoHAiE8xCshv1nMazs7a99SFJvhmcAgYbcfP?=
 =?us-ascii?Q?dOB4N58Opijcsm7DZC+pMw/t4AJjajfIc3QRB4IDJchol5qfDJvxwf6nY8NQ?=
 =?us-ascii?Q?1wsx3r9q3msh/jeVhksn8IUwENhfKx7c2sjmWbD5k9R2zHsp5NuXoPcLZdht?=
 =?us-ascii?Q?Ee+oz7SgoQaJMxyf5vIjHRvsB5nOiIL1z8M8vXBAtudJHQ1ON9u+w1r/tVMD?=
 =?us-ascii?Q?VZ0BcCh5o83/RpnF6PLTus96AQucJTQnGI2lPgUKi0FdsVRXWL89u7IsLP6H?=
 =?us-ascii?Q?GnlcDXH84PrDcR6A6hc0P8NRcUzSJgC9N+mlK4/OMtfn5mqZR+E0r+pvv3km?=
 =?us-ascii?Q?KnRHpG1ALnyuWoT4rFtaOr0H7JU2T1gD/jGVnkCTHjE16/eQius8rVKQsYum?=
 =?us-ascii?Q?USJz7bDg2Qj2mAIw/Aek3/ljKRFYH85I5U4giCx3PKcpNFdGnkLq844TA9XA?=
 =?us-ascii?Q?mnwlRYJmp2UsWpVX2O9XupV8N8Cg4fzuDLBLU/RlSmw5/l3l+kLdNZIlzjGq?=
 =?us-ascii?Q?aiF71PcncxxcYyFbB0yOG9k2sYCr17w0ev3Z9wzpu6NjQK/qXzOVw1SsAIZ1?=
 =?us-ascii?Q?y1nhHSfSbKIkIf/Kdi0M65MKBiDb3O3lbshu2BBC+ooAucxfh4eVgnQjJ4Xc?=
 =?us-ascii?Q?iZEY3qDWqRxYQVfFTEaLV3RX8hQyHxvMCtijuczjaRPuQX12klcwX+Lo39ax?=
 =?us-ascii?Q?DFUrkff2wAVc62wEVs88tWgmhUUkMPKYcMOdleypkH5R/iBGIGOyS9CIE6hk?=
 =?us-ascii?Q?XLnrftls0DOGTJXMs2MafC/ZzgrzvJxaj0ZITX14GoSIisBez2+EKPAQhevn?=
 =?us-ascii?Q?RHLPNfn3I8DExdgI3PPj42IlscumPf6tss99eEnus6M4QzgPqxhOW0PO5Qyx?=
 =?us-ascii?Q?qO69aw2QbcWf536p4aIOoHIGPgug1dTy5JwsLCcJYlZax1Oi2LLt59lFnT/2?=
 =?us-ascii?Q?OK5f+1RaIHavG3vPxhHygw5eolGRFrATxHnSyNxPBXiyH2WXqo5XREPt2S3I?=
 =?us-ascii?Q?K+PS9jZXgsXVFAeaviRrsjLdJOqG7FuNE5dnf+DxwMGpGtnldoKIO5ci1D8E?=
 =?us-ascii?Q?jLjWgZnfPw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5490674e-12f2-49c9-8197-08de8e990b93
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF80B25317E.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 20:15:11.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiUSH34WDOaVLUOcv0V0oijcONtERZR50ol4k/Uhl5ouzEvJbk5hnanqmDXLtGh6CjE0Oj3iLzSvTcfk3i+1Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

On Fri, 27 Mar 2026, David Matlack wrote:
> I think it may be worthwhile to have the nv_falcon driver still enable
> at least one MSI or MSI-x vector on the device and set driver->msi.

Enabling MSI/MSI-x on the GPU would require bringing up additional
GPU components beyond the Falcon microcontroller. I'd prefer to keep
the driver minimal and avoid pulling in complexity that isn't related
to exercising the DMA path.

Rubin Du
