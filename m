Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9FD38E10F;
	Wed, 17 Jun 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682396; cv=fail; b=rpSzm2cbixOLr8Jzvju++e3o5iIyv+wCLSANuwhfT2F+Kt2uLSa0HdvzIt6VE+uToeCTh/a0oxdckYltue80WDzjK/7Wm6hlXvTpSuahK4LhZx7Pc8LCL6rteJk9BFDlIUD6utkMHGxLjH8hDfBiR49RCvGuPoXzBqH+w7DnE0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682396; c=relaxed/simple;
	bh=syidXul06IPCnj2jutmEIegJ1ZRmje/YhyfAxYbiu0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gF4Abk+IhxtTiSigCw2f8mZYsbc0SQK2OOEOlV97p2aJaAsmNux6fEG/DPJ2KEPmPb4N9faZ20hjVaakaJd76h12VUHpSz6zKuUXo4O19LdHf0htL1CfVt2kWZ3N49ND86FyuqMOWHqqrkZkVqYdrARiQfe1NSjVEaoVRzgoTL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCHposDT; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCHposDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781682394; x=1813218394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=syidXul06IPCnj2jutmEIegJ1ZRmje/YhyfAxYbiu0g=;
  b=XCHposDTAMf5Fr1CyFozTH91ovcYBM3b4BqGAyC6cOs29KmdhVgq3vsf
   6dou/yHq0BMwyT+y6RM0Kup5+padTWysvAwJyumV6WCSYc3ZRBzHoWiLm
   dWxIKZTPOtxaKiKU0b6dSmuOgSL350sUI4t6ZUlugyNeOXBOBGjJjEnus
   GNCw8fW9EspZJ9xOUg5JG5+wUjIhEKHkusx0tIv83yWQAdiImTzoq+MeY
   Z79IlpkD9DBfU0FI9sVnc6nsPTw6r+OED0YkaG38ayb6Cc44Eg/WVg0Zv
   b0VQ/gTX02RLzkvYXer6ORT5z4h+hsn+Rev2kI6bfrejSlrHL4o9mLmcZ
   A==;
X-CSE-ConnectionGUID: cY/OYoalRqu+eHuOrxWMvA==
X-CSE-MsgGUID: NOOGoBTnRa+naSEnsru5qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="99879794"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="99879794"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:46:34 -0700
X-CSE-ConnectionGUID: /oEpKWUJRyWSwcEpGjSI1w==
X-CSE-MsgGUID: RhCT+ZBwTp6jTgugNX/8+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="249900663"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:46:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:46:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 00:46:33 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:46:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LO8CGUrsH2frlOBPGCDr2pKtuJLQE3xhQkrHguBBTo5cZyDoV5GgKIjBPy4q3JEfQ0jdgnm4D8UkvBD/P6t3k7ATdOi75NnLiEWXOo/WKHJ13rQeyWpqOGk7dWoildy6y/sU3Xly/T/DbHxD116F952gUua+54yHNse2UkoSBwc44wC/0G3hnTXSTTBL2P0xIcm3N/Ex1R+0c+QLI+KWRqULWbGcoimHIEdAqSHRpHJHoCxEENZuIXl6owyFGc/iiJXGxRk6NS3dqipPnqYvxNGPqH4s6RxlOfFof2sK2dwAno/9muu/LU9EDqC8NNgP9mQnEePirkanhA0hH3MwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tefTWlLJ+kwiolS/uL1EmpUCyfn7JSusCgZUHBCQ4ko=;
 b=PFop02Rv0Zf+WqiZLEE2v4tpu4XeDuXlfWWXsFZG5bsrSY/YUsPoF64TpA8rUjgwIh9/xMKb2HjSzR2fIDl8Lmle2JpZ0o4HkX/DRB69D/i2xcvsv9z4QXV9j8hD3pvTA1xLCr6ir1cNlXt13OrMORIc7vJBQT3Xz4G8sw4XjWW92ZuBPX0/s3Y/9G6eNN0aWD7KEwShxo+6mSy7chaRSCa47D/4NiN7NdC3jDEYipTgP1eibGCBg+yIWJX2LeWrrg76f+glyN/51Vi0yXQW5WaRwqK/3n/vl8cghui/pwYJ5DqwoPYAjCGNttMdnQqZhEQIqDx5Nzf7gBB/BmmRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by CYXPR11MB8754.namprd11.prod.outlook.com (2603:10b6:930:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:46:31 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:46:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@nvidia.com>, kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, "kanie@linux.alibaba.com" <kanie@linux.alibaba.com>
Subject: RE: [PATCH v3 0/6] vfio/pci: Latch module params, fix bitfield use
 and VGA unwind
Thread-Topic: [PATCH v3 0/6] vfio/pci: Latch module params, fix bitfield use
 and VGA unwind
Thread-Index: AQHc/PsGUSPVc9iU9k6V6ZMQZpr747ZCYLnw
Date: Wed, 17 Jun 2026 07:46:30 +0000
Message-ID: <DM6PR11MB3690174BD95DA415BB2550528CE42@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260615191241.688297-1-alex.williamson@nvidia.com>
In-Reply-To: <20260615191241.688297-1-alex.williamson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|CYXPR11MB8754:EE_
x-ms-office365-filtering-correlation-id: a090eb94-a4d7-4162-f9f2-08decc448c0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|18002099003|22082099003|3023799007|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: 2/N+JJsSMTJaa7BzfvMaPeMooWm7UCdksU3SYnmp5bc1xvOi2jgKTxPuGokqt60nHg0Iruqa/hrAY6ON6V1tgvzIyClvZClgcsm0c71d1GHuasYrnC5xkAZBBQFSaEvLQTZdouw5X91OSKyY/g0Vcl5vv5sosrVAyJ4aT4QBPpr9qk3TiFPl0VQ18FZiNsQeTu04KfoDvoyjLxUuMOqzqxeZF8EJwBgn/tPayWkbQjmksdfMyjL5hs0tVXu1qPhIDABtV3z0quEy5jnzc3E/qf/yFcXmHFMZ/ACZ2X+Zg3wvuWW7AVN8AvybhZxwIbKH+dXxm4blsHNJ/JqE13xScgLFLL57qSXenlOb3KpidchsNt4ZVyqklOqEMh00gbVSV8itdF09Ihm4FsqXovZ8RguFdBKp7BXZ4vCJupkCpGMwdSyhR2canfm9vuox7EkyFA3d7ftPIyObeYBaKlbnZFEVqszIiFXqVS9bxAWTCAz5jfqmTcKOO1v5ZvXqHQxbhIVhRz1uva++mpK3ibS8KMaP2UPYa8RLL7PKaMgk2EsJSgllgo1LLsV4f/ZybKix0e+PjvYtn98umITtTRA/wgL8uG9emzw7SWQxOqi9skXPVcG0c+Dddu6uSolPY7q5SrG23jno0T8ol1O9yXpZ/50Dlgklwbi63l+HNImr+cXtuxm7sBuTE6MO5X0A8U2XVgFl3RFYoQ5ZB+SE30fgZDcV2c8cpncb2gngyXREUKhfvftnbg2LI0NPbTQUaQmT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f5kc8tS1IUdYQ2OqM5l9ZC6+SXoqicFbgPa8dtXHnmbeTRps0NVcvuVA8ynn?=
 =?us-ascii?Q?gMMixYtLcMqLIQRgXNpDeHn6AjJa1OxDjThkcGLEb2r6k3TPNNdfI99uKPd/?=
 =?us-ascii?Q?9WDW1o8KFLZVCIKs8DtyCK5IJtU2yAZ8zRBMuRF7Uo7j4z+GQUxwsckkIEMX?=
 =?us-ascii?Q?OREZmUKyteAgQMlLILiQPwsXZK276uA/tZuw65nSUu32QGoiTdPhzzvVm7Eb?=
 =?us-ascii?Q?MKhizSwaVT8lYl7iN/pVGZFfpdHRh0DWM2MChRxfiNfsRvpRjww05OCanyXw?=
 =?us-ascii?Q?aVJPIBU8ayydZE+MhNwflp3GyZ8qm7WNB/4VRQqdKVEpwMuSOpnBBn/nHCPP?=
 =?us-ascii?Q?5csm1LV1zbLNK967TyAb2VRfuvPn6FxR2jPW7APXsBMsAJSTGfgC11ViDS4M?=
 =?us-ascii?Q?2G3NKKkiTIgix1aySZEZnS1+6C+Z3JO8nRg0l2Bm+StucEFMSZ62iEzjOmpc?=
 =?us-ascii?Q?KWXfZJSzGq3POiJBHp/qhwWFHQCzj5S+D1B1Fh8g3KLa5WeYyfD4t+/A+WvE?=
 =?us-ascii?Q?mrkX/l7Xp4kvjd3V7WmXibBN19UD0+1z59+5GqptWyjQEmHTqcksQFlP/Oj7?=
 =?us-ascii?Q?MSbzKEm7AQAAdliBaIFUf6mGXjgj3SOomNzxIxge5tmGk0EIh/JJb+77Q1Yy?=
 =?us-ascii?Q?iLwQi5a9bk9DFi/yIPjWfOfZM10oS0lDjS1LroK97KDZHuZ3gIar2KIswejI?=
 =?us-ascii?Q?wtbp/ErQx+h0kAvUfxTZDgUjbd7g5TY/LxWsAKF7m1dyCD5p2GwRCf2yxXth?=
 =?us-ascii?Q?AcgM5jjXvufB5qPW9Uc3qJe6SEzlHWUukEPnol9GGiahlkzTrsm54w8FKrli?=
 =?us-ascii?Q?R6JH7qTXoRft12NO2dQDhnjBhvyk0HWKqyrixSGeTxZvN7RQwuv5Qrt+XXAY?=
 =?us-ascii?Q?bQmDRTrjVcddwx1DklWXoc7QjOngdomVvw6fC9u7Vd4k8zKkBq5EKuYU9yRk?=
 =?us-ascii?Q?WtzFwfZByibse4dtYPTm4ZprCh55GnGSPcCdFrESfCdu1ocWLIQ8VVKgsOXQ?=
 =?us-ascii?Q?zTUPoYHt9wkgw1cyGi+j0GZ9t68oCVrdzytVC6iE43e8f8J6N+PpbJbC4+R7?=
 =?us-ascii?Q?1IuVPWQ1p4mKhqHMVbwjWX1Eg/jscJrHDF5jlXiqb+37E3q/FG881LRntrL+?=
 =?us-ascii?Q?akNRbwGV6lN9WJ6z6cx2XcK6RNIp45zPCxHpjI9cL2U8B7frESw9633Pv29T?=
 =?us-ascii?Q?ajFeUzxXzLKbTWG/vjUZEV7RBiFSybuENljRXcotsF3KZ3l2CT8ZLPKNBIA2?=
 =?us-ascii?Q?0K0MeBrL460q0z9lTXJOiqQfA9U6EImFoDGPk/9FiE2G+qPBAra6W3GMZXL6?=
 =?us-ascii?Q?3F6ow1IHa3cjGv8jOVKkMcyCj28U843q/t8I6xEgnEslHTQtOyqmlT1KnEMa?=
 =?us-ascii?Q?3aSdSj9eO76bNVbG9nwR/WcpGhEueDkVDXs5JjvW6Mv48aySvKQTVadkUgpb?=
 =?us-ascii?Q?P9q47uVSmBv8PvzhlsYMqBG6PsWLiI3SadDlLA5y+HAMjWjd8JbEOGzK9GpU?=
 =?us-ascii?Q?Tw316NZwXea6Em0I1rvPNcI+O+qLe8mVBrRH7fdoU/+cbGgxZYTAhMIca4uL?=
 =?us-ascii?Q?So1EuVDK/hx9kTt/Q+sUeuLI5jAdrBb7oTT3DY7Vm0URj0GL+jGYni+6MtQl?=
 =?us-ascii?Q?zs/EoNvHYFOforQr8/7tAHdGTHS6CKJ0NBRYSiBuv4bbU174SvZsQEkMP7mz?=
 =?us-ascii?Q?XVl9fM9RSlm5u4NYF5uxVCzim2rH1HTQqlIDKZR792XZ+sAwfWzjvjRiKqdf?=
 =?us-ascii?Q?iVJFasm9Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kQnUJ6GL8Eu8TPQzCp0BrCtvpovsFtic+kbNyRnRaSLhK3RXLN3BcOGr2aQoWIylHpugiREfCv2nx0g6w42jjWu+lW9RndrZs3IoLXvoT6oVlXQ3r3SPUVWZAGjoequUAKFUZtfGnukjqwKHNF/ewJkzTCC2xw63wpSwCHlo88sHlwvSFS+3I6J0JsczomVOx9w64JYV8hQH87vuTvAn8CkVLwPpT2YcSCP+S65rQ2llbL3i0sA0ggZGREF/Fh6cG0pjncxStUd2q0xEj6Kf/tJYFXUZbjK32IqenxHN6SmZEyr2Z8oFYoHH3vmL1v3KNA7LnQdgjjMH2/dBPl126A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a090eb94-a4d7-4162-f9f2-08decc448c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 07:46:31.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9NjCdiNAUm+xOirDS/LHzg9721TU99OEizo6UeMZ2xtuO3Lke5Hs8i/HzXLZ6d4+zvvh2NeyC93xPjTCxFMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8754
X-OriginatorOrg: intel.com

> From: Alex Williamson <alex.williamson@nvidia.com>
> Sent: Tuesday, June 16, 2026 3:12 AM
>=20
> The vfio-pci module pushes module parameters into vfio-pci-core at
> initialization that change global policies for all devices, whether
> bound to vfio-pci itself or other variant drivers.  Not only is this
> generally bad practice, but in the case of runtime PM, policy changes
> can affect initialized devices, even while they're in use, resulting in
> unbalanced operations.
>=20
> This series first addresses the runtime PM case as a separate fix for
> stable, latching the runtime PM support into the device.
>=20
> Then, in preparing for moving disable_vga to per device, it's discovered
> that we lack proper unwind support for a registration failure, leaving
> the VGA arbiter client registered.  This is resolved before it turns into
> an issue, also marked for stable.
>=20
> Next, we're again reminded of the risky bitfield use in both the
> vfio-pci-core and mlx5 variant driver, therefore before expanding use
> for more per-device flags, perform the binary split to categorize
> flags as either setup/release or runtime to avoid RMW hazards of the
> bitfields.  Also for stable.
>=20
> Finally, close the series by pulling vfio-pci module parameter policy
> out of the core, latching each into the device structure.
>=20
> This latter change also has the effect of restoring the mutability of
> two of the module parameters, where that functionality was lost with the
> vfio-pci-core split.  With this series, the current parameter values are
> latched into the device at probe time.
>=20
> Please review.  Thanks,
> Alex
>=20

Looks good. for the whole series:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
