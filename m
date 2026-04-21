Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14E3BE630;
	Tue, 21 Apr 2026 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770885; cv=fail; b=VLWs9Yz/r5riKl3thNar2/l6ozhTHzyiyTfYOur0G4zfbiEsWGWfJFVG/bc5itEGbx3tCfty9RgFbDjTujbocXfz6vpnJj+SN6itAftuPGo5qr4S4VFbUUDwbgYFB99uUp7YNon5KVePjlzbjfiREdBULaxLORAJfd7KpINjlcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770885; c=relaxed/simple;
	bh=1l/S8LtV9ZU3eZSTcNxgax2iivUZf4QhqqQPg8uRWog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YUHHgcpxDLuLsw/NzTYLMkTSRgd8Q+X4aQ8Xk6apUABIRHQtEFKk/jHH1Q8gXrLV8Tj/VFpLPd8aTDzPDPcLZmdPiNl3MBigMg7Kc+6NUuVPZlSLClBL2LCAjEfpWoIER3ovuzZ+4bfWEZJb2e2emyQ/UKWC1tPv2aGoib1qawo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HBy+x436; arc=fail smtp.client-ip=52.101.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HBy+x436"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=be/0WVKCGBri4nwKJaKgsWHSZy5EeEHoCCPYi1swlMbG5FAxvU6y5KPrpITIhjH79oGBVxhefUS72dWGejw5bkUi4KnR6Ts+S5Wlvn3nd3UTJZtdPK60/xa0A79dZRUjCfNBfD64WZHP2Hu1hYwXMATMp9ec7TbMsXt/qthESO6Ss2a7WOZqVHL7BgRgSczuaCSwpt2I1tMn7Vah8CcP8YMIPA719Xjo3OOUO0LugW9irkwUaziEaMAJv9uMzb8JJuhfGbGDk9QN+fId5SDNi1jsadRziffRp6Uk2hQ0LcyFusocc3RoUVKv5LTJE6TTYtbFrItShS9KGRO0sO88Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0wi+3ErD6y/f4NVdM/DIqhoww7VbPQOwturyssKk4M=;
 b=bvBxqDWELL1bioz93enGVN0vfu7H5UY6e1EaRjByfATWOjH8kmUcCelk0Gusosz2VwvvuV+Q8Vn9pxDRT4atKNQpYy6P6aO69fSAuk4mxVXFjs5Vw0G98zB662GzAm9iMq3cw6DjhOHgjJ4zb0KbQFC/cdoTucGniVLJ8w5dq1GTk1olVjMNWAh51ZafWtg2Unh5fu5cs6XCWrCxYbHbBhhOWqEjHADscJwFOuxBY2lVk/WejNGMzlo3end8lYOpltZstQvj3FlywYUErdhIFnHS14lPlSj6KOo4KTe3feCfNkml5f8LFhXCo/PPB3A2CHWO0wy7e2dGNi+T4uNsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0wi+3ErD6y/f4NVdM/DIqhoww7VbPQOwturyssKk4M=;
 b=HBy+x436BEoCZXicYpeQrqlnchgJpfZL7xK8hDcg9BV4aYb8FBVqE6RgLGBhFpJDl7YfG/A0duxv66np0piQBJIrh8Aa2C5SofU/jAAdAjrWcqVmMzWeDQ7WmObdY69/3QtGY6W3ZL/l9VEibuJOL69xkc6GLC7pteFoZxbK8jk=
Received: from CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Tue, 21 Apr
 2026 11:27:58 +0000
Received: from CH3PR12MB8547.namprd12.prod.outlook.com
 ([fe80::bf73:429d:49fd:26e1]) by CH3PR12MB8547.namprd12.prod.outlook.com
 ([fe80::bf73:429d:49fd:26e1%4]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 11:27:57 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: Alex Williamson <alex.williamson@nvidia.com>, "alex@shazbot.org"
	<alex@shazbot.org>
CC: "ptsm@linux.microsoft.com" <ptsm@linux.microsoft.com>, "Gupta, Nipun"
	<Nipun.Gupta@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] vfio/cdx: Fix interrupt trigger races and
 consolidate MSI state
Thread-Topic: [PATCH v2 0/3] vfio/cdx: Fix interrupt trigger races and
 consolidate MSI state
Thread-Index: AQHczqjG1ydb4y2sV0WXr8abXSsQHbXpZItA
Date: Tue, 21 Apr 2026 11:27:57 +0000
Message-ID:
 <CH3PR12MB8547BF765593C6C5B2528ECF9D2C2@CH3PR12MB8547.namprd12.prod.outlook.com>
References: <20260417202800.88287-1-alex.williamson@nvidia.com>
In-Reply-To: <20260417202800.88287-1-alex.williamson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ActionId=190eb251-42e9-4ca9-83d9-c797dac0b51d;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ContentBits=0;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Enabled=true;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Method=Privileged;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Name=Non-Business_New;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SetDate=2026-04-21T11:22:05Z;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8547:EE_|CY5PR12MB6131:EE_
x-ms-office365-filtering-correlation-id: dedcf2bf-f2e2-460b-1004-08de9f9909e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 +A0z1IC9W87BOTeg9ZRevga2LhdoFZzfgg8y8Ic+pZp5q6rGIFxprrl11rE0K5arJXW2XFAMt7XyxfT0vzS2EJhGTHFMMXXj3BrThN5yYnBn1pnbaQdo9JxNV3Gdkrka03jlO3+gwSppi5TGP/u/f2Qy5RqGWENK31sRWH2mWpg4cpz9eKjQjNaOsMZ97p+xhsWJcFMaSM8BTC1bJs4YDq/dli49BHOyFmnajykWmtNulk/XsoZBNoGF7UMGRwai83K5I8NfIvM3mpdIVJWOUZA3reWYDQDgRub9/Gt746QlJFhMLtRPAeUBTJyYdnLipcCO4jKpX0WbSAFLcr1DHtXRzp5jTat3oI7aTTuSgzQMTdKdWhvPGwyN5dBWlSTY7tWpWgAYb0d7VmAHxeKNw8RR+4CWPGwcXX8G0tYy5g35ii40utZYr+IYl5g31B3BpnvEPINWqmD9VdR6ogA7E6Qit070UwoPWcPHQGfM2g44nwwoxzOdDmeD2dDxbUzlawb6LpBuifWoDgEPyqFpU+pIii9AKFe3Cgw3nAqx29fEIxNaIaDPjh/p+j91pcptx5FKns5ZUE/WskBpx3TV459Y+8jUkSL/b0jRBnq2WAWmaFnX7MJObS2iBnPAXusTw9McuwQRFi8EgdOlNvubw+AZdkTdUM4Mz8MwHthNq8+a9k8jOWpBjFe4YbpD68JfJ98IudcqkoBHqPMOC2qEAcEXYudCXEoFDpCHnbZLCkV7Fw29n6ZuVFBLRg6RN9Q2Ez9NkAhhyglBeHLltkeqUE1KEq1usgEea1oOUisWRbQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8547.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9wvLLe1RTCEK7gYQDgV8wnxEgMOfspNtWXP0F4xmZAhglOaoX1tMehIdTtmb?=
 =?us-ascii?Q?uqmRNVCSkHirgG/KoiAbrUOmkaTMjsWltaQoSpL0bZTN3oQ+ilPCfNQRJoTt?=
 =?us-ascii?Q?LhWu6h9yn0f9QYa87R5BKS5QGG81jermPGAlWeCbIv+ZVVEyqJ0CyW/uZNMW?=
 =?us-ascii?Q?ROa8N9k+E9ee0mWeXppcf4Lqw4a0J2IvfXywtKcH70ETPKjgS1NvBmBsUSG6?=
 =?us-ascii?Q?lGU+iKUMvRWYNrv0BGhgSQe7T9U0D0TWMhKAB3ATze/NCdspdNxnLg5AW/Z4?=
 =?us-ascii?Q?T5CKwbXxpLQnhcxfACiF3VEv3Ffmf/d4Zaq4svOkOcsEOkzZx8FWnJswcPF5?=
 =?us-ascii?Q?ZnLbGcCo3nGSKzx+Tk2IZZWRPhoXkAF/5FCgmr8LoPUjuDkAL2G9qSJEpjsh?=
 =?us-ascii?Q?T+XIXHTcEA5GxZIZQvRiB/+/H46JpBnSTdHNhDqEYrFELEdVrAIcIj6RZ757?=
 =?us-ascii?Q?vlYopMtNCAZUXBi+xipllop8LsnVBaQDhg2WfUFw4MTo3oEqnuj/yh/JMgNf?=
 =?us-ascii?Q?BY6Nf0bavuhSKmydHTyhKe4jK4rqaWdxqqSf/tYHupbaUZuhinvVGoleJu8E?=
 =?us-ascii?Q?KQ3kkGxgmczhNnBNULo3Bq+LFWsVSKikUJhpUP0SQ0envHiOwribVsRBkDWR?=
 =?us-ascii?Q?XQok5SrnEBjwKEyZ3SnuTovO1UDIwKU7afxTDZpSoyvBzVt5WVXkoFzYpvx3?=
 =?us-ascii?Q?MnL89MULID0C+bcCly4h49SKQTupN8pb5ok2DHfInJgPE9MmCYy/rH4qErkS?=
 =?us-ascii?Q?uWtpz6yN/poOT/haEVRHXv4B+dcEZ4xiHWwuvYzPNPQwdnyVF6NxQ6ZPgfg8?=
 =?us-ascii?Q?gn+XO3qoNOpcZNMEkCpSdW0BPoY2kHacxzxTolRg3hZvNazPNbm8PC2AaNZv?=
 =?us-ascii?Q?yyM4JsBAMOC2dMsKlNJnee/JYYFyRAAjkpMnEJ+oiZg7tQQjee5Ud3Pw5BgT?=
 =?us-ascii?Q?D7F8rvhElb1/BeXH+4oQDxHS7Nur0ItTBEBDZQ7iwq+P8aI6Od7LwtCnK4GN?=
 =?us-ascii?Q?C3OzbYgOwgGhdLoZsUs9gtKBwW08pWLhqw9yMbTIhrMWr83H0ZCNFuLtsq1m?=
 =?us-ascii?Q?0QpWIF7xxBg3WXBhVgLGoeMN3av2kaKho5DPM8dZscTEnWXOhIwWOiXMsdix?=
 =?us-ascii?Q?wYXaoAkUM0DdEb6H0ofp20cVU6oJu9CVLr5F+ziCuB5iQU/HaSe5faL0LoHb?=
 =?us-ascii?Q?zsTdGckxBEN/NeBKe6urGkjkOJdmGc9OjrKxJPklcHGKOofe8Fe8TV6oYVbH?=
 =?us-ascii?Q?biMY6FpaPI/a0DVLml2V3bVLWB32pi1WUDD/dr01yXfWyu7M5cmvVxatUmp8?=
 =?us-ascii?Q?+WvsFOsrnECPMdlo5QSJuINXUUICt5RjCgn1PqS/1M0XQUaVF3eHdrBtRd91?=
 =?us-ascii?Q?ecO0W2Sn+EP909NpjWYyqjuSaeg//xp3a89xEns9uFiHhIyUJHhAG0VqWHgP?=
 =?us-ascii?Q?V25v5vI1GNOqyztnfX19TT/9a40hl1m8nh9X5xT667FJhVu4z3OgwyqJFJ16?=
 =?us-ascii?Q?FX/qS/LZPSIVlIhldAxtBmzJb6WUqDLe/uKMGChrJpDTKVDYSTEERX27WOIK?=
 =?us-ascii?Q?VUw/Jogg4LR4mHD4Ukd06BIpJwEOKiuuIfFiID8cF6xx2oIPPpKxFh03jD0z?=
 =?us-ascii?Q?kNLpHnc9AMWWFqy1EKxLPUdrjAFACi58Lqk6rX5yA4hx4fDBRCqDtSr5uWO5?=
 =?us-ascii?Q?GyVBJvZvydA9Qp+EeLZu3WU8TrpRTVVc+N85w+F2PMvVVo/d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedcf2bf-f2e2-460b-1004-08de9f9909e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 11:27:57.8063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGqm+NNtDxFuRz6otcvY4f3g6LBthP5LvcLlAoy3/FMwuZR4BPuulZX13mKaTiIK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131

> -----Original Message-----
> From: Alex Williamson <alex.williamson@nvidia.com>
> Sent: Saturday, April 18, 2026 1:58 AM
> To: alex@shazbot.org
> Cc: Alex Williamson <alex.williamson@nvidia.com>; ptsm@linux.microsoft.co=
m;
> Gupta, Nipun <Nipun.Gupta@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>; kvm@vger.kernel.org; linux-kernel@vger.kernel.o=
rg
> Subject: [PATCH v2 0/3] vfio/cdx: Fix interrupt trigger races and consoli=
date MSI
> state
>=20
> Prasanna Kumar's original patch [1] closes a NULL-pointer dereference
> that can be triggered by userspace via VFIO_DEVICE_SET_IRQS with
> VFIO_IRQ_SET_DATA_BOOL or VFIO_IRQ_SET_DATA_NONE before any
> VFIO_IRQ_SET_DATA_EVENTFD.  Included here unchanged as patch 1/3.
>=20
> Review of that patch identified a race in the same code path, where
> concurrent SET_IRQS calls can potentially result in time-of-check vs
> time-of-use and use-after-free inconsistencies.  Patch 2/3 adds a
> per-device cdx_irqs_lock mutex and serializes all MSI state updates
> through vfio_cdx_set_msi_trigger(), which is the single choke-point
> covering both the ioctl path and the close-device cleanup.
>=20
> Patch 3/3 is a non-stable cleanup that aligns vdev->cdx_irqs to NULL
> in error paths, thereby allowing removal of the now redundant
> config_msi.
>=20
> [1] https://lore.kernel.org/all/20260320101933.1554416-1-ptsm@linux.micro=
soft.com
>=20
> Alex Williamson (2):
>   vfio/cdx: Serialize VFIO_DEVICE_SET_IRQS with a per-device mutex
>   vfio/cdx: Consolidate MSI configured state onto cdx_irqs
>=20
> Prasanna Kumar T S M (1):
>   vfio/cdx: Fix NULL pointer dereference in interrupt trigger path
>=20
For series:=20
Acked-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
=09
