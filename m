Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF83905E8;
	Fri, 12 Jun 2026 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276736; cv=fail; b=PFnT3wgjvh3dbE8CQU2MUhvYoLQaomwRQhhlry4rz0JJiHJFgJW4CsiNrX1hAUPnIkVtkKWyuzcpb00G420srP0gvsrCy54aM6tFlc7hDgnNswebwc59UExn+PR2RVu4vF/LOJ8X2LKgAO5kYSqND4MTMmH0cjabI5VEWNYD+Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276736; c=relaxed/simple;
	bh=E0Bc7A9ZyinYQvkmNLnkCk5+PDOOpKA+ge9/OPTcGto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJviQ/Ef8jBvNRtADjJ+Q6EOvrjLS/Ls5XZBzyehHE3idWiawGQ4Tm2Tfg9qQSFIFvAiD2giS3cjrviwQBNORNILH3dn3NpakDd2GK4RMPPX59dRmB4e1n1C8NpYelNV1NM4G1KjZ03nh48R1AxgEqEF726wpIBfEe7VGfrDyQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aGyzwxdA; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aGyzwxdA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwwWgO57PkUsMfYPEehuGwAvO9Ive8Y2y62GtNhH7W9gv7cW0R4CMss1vQ19R3FfreHH8raBz9xeo2tNLxnKbqpWFt2IHAbq8nXHkkCNWJCyX0NTtAeyd+t2eMheBSFAwPx9MmLtEdS18vtKumYyRvZfelrD8kirO0hxLVyfRjavVDMu6s/98Sn7kKcwPA05FRXkmqnnK3W6ibWmFZZOYCS89MijL3b/rjQmXS3nprYojw/QxeaEGIWQdMCPmlogout5Dul1g3fhooo2ljkTEMZQnxpesbSQPZJvnH0b3HNEqmADQMDrwNe+rx5HyWej1MZvw85eDqVWBdqStq5JXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rthgir+xyJUXe+UuoZsOu0CaSgUDAanYxJJXCMqYdjU=;
 b=kNGlDSPuRU85CmvtkzZKxn4gMGWiPG8gIh6U/ipgKmnsZya7mZG/cnCQsw1s6W1sXGH+l9BE44oX5KhC8IdVsUJ5xZc+w8JLMJCpxMZSsty6v/2aulUVokesUiYiq76bzCd37Nr66IHIrzvN0vuKxBmISgiJl2Q9P0gl1llYJPpQCyjMTTSMHrkSXi7d+ddOhF2HJaC7GOn+U1Z7IdGKEo1y66AhXosUB5el2G/3daIcoUOjNWbnquxzoA9DbGqJ3KI8IX4nzlmwXe77YY8EGURiEOAyDEnBH5IoRiiRrqvi0EGrKXFaNRTzcnVq1FGwVZ17tFCVCQXHvEXFrwww3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rthgir+xyJUXe+UuoZsOu0CaSgUDAanYxJJXCMqYdjU=;
 b=aGyzwxdABwzKpmj6IJCuW2z/aV4JNNk19JCQ4fceb5r7i13uZFTHaRacVucmRYDkGpg/jKUq9AVF0ldI40TM/bJwgGIhHnfO0DmGVul+vERhagAwBGv8ad62y9N+aW7NE7bMuDJkCEbj8g0WE/emwwtUtWi/qKtnQ0TUjsyZrVigv1eLvSGiIjfRiiMsy7ktDcpsYxvQM8FPwrL2rFTMuYFG8w6cnmXChcm2aJT041oatGiMRXcaugjvIH9rru3+D0ecDqX+BDv60jenGSnMTlpDiSLbMz8ln9LLoiYMZ2it/h97d2WhCCWIideH6uTPDpir6aXdrhRhGF2zcnm+aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 15:05:27 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 15:05:27 +0000
Date: Fri, 12 Jun 2026 09:05:24 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2 5/5] vfio/pci: Latch all module parameters per device
Message-ID: <20260612090524.6101e9e5@nvidia.com>
In-Reply-To: <6d737961-1276-42e2-bb74-510d0f041040@linux.alibaba.com>
References: <20260611213539.4100590-1-alex.williamson@nvidia.com>
	<20260611213539.4100590-6-alex.williamson@nvidia.com>
	<6d737961-1276-42e2-bb74-510d0f041040@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM6PR06CA0083.namprd06.prod.outlook.com
 (2603:10b6:5:336::16) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: b81fffb4-0a9b-4499-0e72-08dec894096d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Wr/c5QZJtmOUXPJ7fhPLtRTTvjUIcni6u2YBgCpuhc/A3KBas8qyQseNtoneR41gqvXxQlBOGkDmJofQs8gN/H+aPrZq0a8S6Gijjz2xB1QtaJBk2nmXcL5uaMeAlVRvfB3X31BQ3yKJYHttI1LHv/ohEPJlPOwQzKai0HnPrHWleCn1X9555yyuCwZxjV9sch6X9zHcrm9wXelssQ4O+5UiHJlXLZLXhuAcAFxAXz8zVu3q4C2A1rmsF8U6WOhq91jSQmDcwHlvSFbv81tuLgTK/Qxrby13HbM75F6v3UO6YDXwTxn0XtkJjgaGkAqHWK/7LFb8rAQFMLwTtm7KhhCSENvv0ZVN7tOBry8/DF1fhpJDyZGqfhh/myOisQZTboKGg2kxT0tsZqU4rkeh8WdzvBvwbQos8MtcY4O3lwVz8J1rv1H0NILrlU/GCgNzbmFDBguCku4L9pgM2LxOsWSZ0cjsodjAoM+a/lNYNEs7O3pzj6NaByAbIVi27my4K891p2bzbTQtSLUNcfVPt0JwBAmmcUB/rnGcB/M9rZbITB/Qzp8yWs+w2mQUmZcxQpftU3zZYIACZ8L2CEWqaXTn2AthKCbD/8ic7F8FvZNUJ8G1mMf5jKb02UIBDC4pLXNoBA0qq/TU/Rhd3Zjsl6aqkaS6Z77r89POo2FqBQ2slh6mvE+LpATo188nxp14
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2JFRVM5RjFaUEd4dEVoSkJlNlBNRmJ0ZlUwNFU3UWJuV21xYUsvNStobGJx?=
 =?utf-8?B?S2NReG1VaTlJNDZpNE1HWXlxanIwckgzMDhWQUNQN0dmTUE1cVExbU5sRkEw?=
 =?utf-8?B?SmVvVWVvTTBJL3kyTEludTlZc05zdWRad2dUd095V1E3UWczbzlkTHdoSHd0?=
 =?utf-8?B?QzJNZ2d5MThGLy91SjllUXdGK1N4eVdwaEhobWFncWh0TzlUaWxlaFlaNGFK?=
 =?utf-8?B?T3BBVEc4NHBscWJNMG1YZDVSSnlXd3lZVE1xTERVUU9uL0dxRVU1RUlUSG0r?=
 =?utf-8?B?SWlCZlUxaytjRWJrbDdOREx0emxqTi8xbDhvQWNUUlc4V0p5ckJXZEY4b0xD?=
 =?utf-8?B?ZWxPZHB0RDhWVUtwUVZlWTlvMTV2MmZiY3hSKy9QZ2p4WGxBaVJFYzl2VlFX?=
 =?utf-8?B?KzBBejBkNHcxRVJJUTM0ZHFNcXU1YkxoYndtZmgxS2hOMElqZlFtTUZhVlBX?=
 =?utf-8?B?SUdSak1xUHFFNE1aN01OakMyTDA5d0NGaEJublN3ekhsdThsc3VTbU92VS9G?=
 =?utf-8?B?QmdzcVg0eUhhVndkbkp0b0lpeEYyYXoremhDM2IzSUFXbXJGL2txeE9NYTlh?=
 =?utf-8?B?Z3F3WS9aUEkrSzliYVdhdWUwK2p1RmVrYmU0MUJBdkg5ZlBhendTaENqS01l?=
 =?utf-8?B?a3IyMEZsVGZYTGVRTGdMWWhESVY2cDFia3ZDYmkvOE50VVV5aGVWVnJlSkdu?=
 =?utf-8?B?NnQ4ZW1lbnRxZnh6cWhhZGQ2TmUySDdjZWtrdTU3NVFpRnZJeU90ZW5ZVlQ4?=
 =?utf-8?B?WTVPQ1VLdDI2QlgyRmxXVmw4bUtldWxXaU1PTmlCSDJnM1hjOC96elYwSmpn?=
 =?utf-8?B?dFZjM2x1N09pUWRPaGF4TFpZdVl1VXNGZjdaRVlHVWxZMjNHMXY0MDBBZFJt?=
 =?utf-8?B?djJhWFV0QytNYUVTY1FENi8raDB0NzRpdWN0U21UeHNnc2x0cm53cnNtU0dH?=
 =?utf-8?B?bFN5Q2pMbzE4SnBlUlVIL3hrS3VwRU1KYmFxbzlEd2xPK1FscnROVXV4aTRh?=
 =?utf-8?B?OGhsOGtiOGxUOG5nUnJpQytYTDFBUHBUclVoeHdCQnhldThGSC9XY0lCQVE2?=
 =?utf-8?B?cm9naEF4aVNNSlRMTDJ3bEdEZVJGWjlINmZudk1oTlEyanl5Z0lrZ3dTMUh4?=
 =?utf-8?B?bkZYMG5QNlN2VTMwTnQ3dXZtMDhZci8rWUVFcGNkTlNsTW5qM2ZDTWdEcHRB?=
 =?utf-8?B?QzJTNjBrRk5BWDBaSmQ1WEhDSUYybzliMDQ0N2NqR3NxOHQyQU11eGEyaG95?=
 =?utf-8?B?ajFIUGpqOGJrd0x2dEcyd2dhMWlJcXBqVi9XbTF3SENxb1ltSVRRTVBLSU44?=
 =?utf-8?B?V2ZaM3NUQXptQWk1V1A1Q2NWakFLeXhSejAzc2pTeEdyQ1VZVWpNdTFFdHVo?=
 =?utf-8?B?MlN3MmlkUnVzYzBEbGZmRW9lMVdnbVJ5Q1Bsd0k2WmxwSHpmZHlSMC9Eam9N?=
 =?utf-8?B?NVFVSklrankzL1U0Y2ZKMko5aGtwdnJpdVdaSzRjdUF0QU9ScWdyVTkwVUVI?=
 =?utf-8?B?dEJuWEQrM09xRFN6clpEWkxVbFpBdjdyL3NiVVFqOGdtSHVzVXpGUzFuYnRa?=
 =?utf-8?B?TTBaM1pzRGxpRWgrWmdMeUJKWDFQMExSUGlXSDhOOEFDQ0hZL1FCRDI2bXB4?=
 =?utf-8?B?SUpmTkE4SkpUWm8ybmJTNDlwU2pSU0dPc2xMK1RoQmd4UG5jM21FQU5Mc0lm?=
 =?utf-8?B?THZmUW5yTzBvTTdJanFlbGxJRFFMRGlvWXBZQUNXQlQ3WnBnNnVGZXk2TmlW?=
 =?utf-8?B?MFpUVXRJcnVmeFZka1VWenF6Q3F5VG45enRXaDUzL29hdEJNTFJVUktaQ3l6?=
 =?utf-8?B?SU45OTRFN2dnQm9yby9OTFVQdDM2L0d0ZXFYMUVxdGxDQUlnaXExZm1VclVC?=
 =?utf-8?B?UTUzaW9xbTVJMVhyOEtWSTg5aEMyckt2TWtVaFQxTDJ3bytVOWtkNnEwOUtl?=
 =?utf-8?B?UXRTS29Zb0VpT1V2NHd1Wi9VbUNyR2RvYjM2UnBndFRSTlBmRVYvYWNkTEww?=
 =?utf-8?B?OW1QRGo5Yy9UdDkrR0IyTzByb0JoQTVCdTlDQ254UXExQVlPeHVMaFViSTdk?=
 =?utf-8?B?UWhBK2dUVHlWTURKTERsSVhjNzZ5VlVYYzFXVVFOMGp3UDM3TW91cjVtUjI3?=
 =?utf-8?B?bFRRcHR4SW00TEl0ZWJtZXBleGlJMTc4MEJWZ2VYcnhMNG1tMXVOWUVnTmpo?=
 =?utf-8?B?bWFnTHJ0U2x3ZkV6WmZybkxDa2cwNzhlUUhCbVpSYmt4UXpWUi9CN3luaDlY?=
 =?utf-8?B?MzhDTDZEU21aZldqTlR4cEFZSmJTYURYYTBSalZZVHRiQzh3S0RWYVdUVi90?=
 =?utf-8?B?MTljTEtmOFJnZDQ5TDFmU09sZ0htY3k0QWFCbGxJYXExcGVacGZUdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81fffb4-0a9b-4499-0e72-08dec894096d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 15:05:27.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMK9LZXfJk1n7Kh2WwNk/ys9Y21vW1K2CYtDx7Yvqd9absNGYR6tbdaiGaGzHAQOuJGvgROPFnINTPgpRMMrVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867

On Fri, 12 Jun 2026 14:25:16 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> Hi Alex,
>=20
> In many cases, when users modify a module parameter, they expect
> the change to take effect immediately, but that's not at all what
> happens here. So I think on the one hand, we should make the module
> parameter read-only; on the other hand, we could also expose this
> information in the PCI core device's sysfs directory =E2=80=94 read-only =
as well=20
> for now,
> or perhaps there's an even better approach?

nointxmask never took effect immediately, it was at best setup when the
device is opened.  We could support that behavior again, but it's
actually more limiting, all devices supporting INTx would latch
nointxmask on open and therefore require an exclusive interrupt.  I've
encountered this in debugging, where it's more useful to isolate
nointxmask to a single device rather than modify the VM config to
remove devices or unload host drivers to free IRQ lines.

disable_idle_d3 manages the power state of unused devices, where
setting disable_idle_d3 never woke devices that were already bound and
idle, it only affected future use of low power states.  I do still see
value in directing this behavior to specific devices, it's a runtime
diagnostic versus directing users to set quirk flags and recompile
their kernel.

Therefore, neither of these are really improved by making the module
parameter itself read-only.

Given these are largely diagnostic, debugfs would be the more natural
way to expose it versus sysfs.  We already have some support for
debugfs for exposing migration features and state.  This might be a
good idea, but I'd also argue it's more of a feature scope, whereas I'd
really like to get the Fixes: and behavior restoration scoped change in
tree asap.  Thanks,

Alex
