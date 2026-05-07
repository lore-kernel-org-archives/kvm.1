Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC3631A7EA;
	Thu,  7 May 2026 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141100; cv=fail; b=S9x1vnJZQHP5m7fqHQHebGJGyGLlL08b8tbPfzQU+/L+e3DuIS9wMXcyH3+tnKV9FRaGEJvX7LGnqMd5Rbty4LyeOT01wKJGBYVRhYcwWydOsTVh2oQjRYbIbd2g5etPYMHCjsH4P92V6G/I1g5FuAFANPqXxi8SzfutgFswD9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141100; c=relaxed/simple;
	bh=ni8qNptVxIjN6+jCZW5kpv/GROokbdLluYEznz/wzBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUsrT5BnodnK8Qx1NtsFBrLF2+UlAs+b2iCvizLNPZgdx342TdjAR8VaSiagHM8lHXUWuq7iIt/2fPRiWqfvGTwpgicZCprr65pi5tFzlu4lX7/r9WuVSj3c2f8edI6jfro/0oojfYn+NAvD49FaEu/c6GPDeKNwDVmsqulOOB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doGCxzyW; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doGCxzyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778141099; x=1809677099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ni8qNptVxIjN6+jCZW5kpv/GROokbdLluYEznz/wzBs=;
  b=doGCxzyWzWGX9FZRzP/ehVOHbHwjBdMftfRTvNBBSdsY859W+VzyDs+M
   sGKiQ18qPVoMqMJ8CXPLPdItLx2qrUcnHnasD/vLQrVF458xMGbcuWHZ1
   RalyOv6j9AlXy4AwewLpgAIxwQwND9/ZIAc908hlhxk+1kTVYBz5PWGdZ
   4fam+JWsLQn1/LYELmTTlpEGFjCwlNnW57sMWcKh5e8ztNqSHdXM6SYAo
   NzREssx8MAwabd0mKJ6A9PzrRAsO8fogRxsQsUhPchvrb3R7O4SFnABus
   03c8YD9CuJr+qvLE16x3PTAQcGr/UK3C6FRVuyfm4a39uYM1btsDiuuSA
   Q==;
X-CSE-ConnectionGUID: Pue1KQi4QXa7qnEKCiohmA==
X-CSE-MsgGUID: 27gmMhWiRL+2T/oD5SvmXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="101759647"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="101759647"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:04:57 -0700
X-CSE-ConnectionGUID: D75CacC7R5qWV3Xx4ozplQ==
X-CSE-MsgGUID: w4RujYQ8QEOyOAgovBSM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="233305713"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 01:04:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:04:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 01:04:54 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:04:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cd4YHcm//IyaWwPeOqQV7wofwCE13rRtdis2oWZzv3o8Q7QLAgFE4qNmRlH3EvoM2Kb1HgkZPYV52bnRDiAo8wuDfDgOPKAraBAfxoOiGYSr4SLGATguk0hieLLgcOdz5CbyR4P+nFGk5+L9BnwHC/mu0XYKnSjYhumjM34pKSRYGEARTNCjQtZUj178t+kz26X1xZnfBL480siAlzuMTMhm0UFRQwAnzoWX1EhbQpNRNW/7nuxY2bJywuUSZHPcIE3oHXnulkJSJf3JPaf7aTg5/dLftg+qc1dB7s9AStofRqTMnYKEaNVYxptAtoTF2rDarAQ0bo8N9z7G/XYyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ni8qNptVxIjN6+jCZW5kpv/GROokbdLluYEznz/wzBs=;
 b=UUufy9PphFaPMSjO1HI6yxXEeohLseh7tdhVKVvcnNQx+8yFf2BxpYFFAzIHwJmCbLk2cgE8dP0FNWvWUfPJJv1+tSzaHYlwYN4H0RfTnkajCi+erm44N9YDxKYMtezMC3zLTGY5o+mlstnlAJNrtF0bjfB+2Rm5xQLjjskk+OzxDMA4gvZi5NLkfcwSvqA60+1JwiNEigcQ9d699h2snbyxJurDXAZ9LJchPEpvuKEWIpZTBLcGWfBnSpunCblicS/uVH3bykgrdD8akruhGE/f5NG0+b4bc+w737dsFsxPl6KUR8tJHBmGYtHM6t+idENva/PcDdqXOHCK86e+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5915.namprd11.prod.outlook.com (2603:10b6:510:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 08:04:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 08:04:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "zhaoguohan@kylinos.cn" <zhaoguohan@kylinos.cn>, Alex Williamson
	<alex@shazbot.org>, "Winiarski, Michal" <michal.winiarski@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum <skolothumtho@nvidia.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	=?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] vfio/xe: avoid duplicate reset in
 xe_vfio_pci_reset_done
Thread-Topic: [PATCH v2] vfio/xe: avoid duplicate reset in
 xe_vfio_pci_reset_done
Thread-Index: AQHc1eRHL/e3nJFiJ0iRg5z+Oc6LCLYCRHKw
Date: Thu, 7 May 2026 08:04:46 +0000
Message-ID: <BN9PR11MB5276D424BE9BB733539B59BD8C3C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260424091719.58800-1-zhaoguohan@kylinos.cn>
 <20260427012128.117051-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20260427012128.117051-1-zhaoguohan@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5915:EE_
x-ms-office365-filtering-correlation-id: 53aea3c6-2d55-46e9-6b70-08deac0f4dc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ZpL/Fgaq/Dkt6xXozKMtld3Z6Icdb38VMr3RM6xegUVXDh8z3eNJUaV2F/t//MY4sjtCXFWgUmAYdWSrBwh6N9C7iNrF/+1cpE5gn+e0PiQqBpdMFnXgg04LkUtIOver/9ORxma/g6Kx1GHxgW4BNg+qOBboTp496W/7kWD3BEKaFv38hMO2oyJJslPuDLF9kZrcUoU5bi1u+rLqKktEXpbJOuACj5hpXeCuQ9xY70cs1/NPkqmbmSKz2CVUQRITtJGO+K2Vzo6KoWrWjhSgcOY3YTV4ebtMtDbutyZ7lLIUAfcW4NO3JdTjRKX1TQos3QNAMWbLtuf0r09YrnAoDJPfyKi+1NN4GlBCj+mzbnTuithp7jYs7io//EbSexIhm6K2GaPiwFYBjT1HJpa7vnbupOpwxee+kp4vvz6Gq1v6uf76GENWHficRRqrdEg1Dg+nxUDQA8tJbydpcXGxXjagEwBHG62OIdNbVpvAoHYrG8cBPQYsq2rErKXjMe/jpSp3K68+cDkLKpw9v4ZJ5gFmGSVHKDByHUQxOCTlCqSdkLPcpX1+A5nwZ5Fbvefs3J8kqurYWwtSpFT35lxyti8cB7VXVhbhbop7xO2u+a3AQR5MqV8/QhIY0eAecd27ObRUrcYdlPk6RoM4hn3kTgkG5MD/YT/T5FDhqyBjnslVNkDU0IZU9+oitIN+yC7e1f4rF0seZPmXQrZwVxlYNs0gR0bds8yy5l6Q+tpWyB7+Ej5wnu05jalp1tkK9gO0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/BtvegnedjFS57qE0d2jF6+3W8KPiLXrD5jIc9fC/+hJLaK4yfXHMQFwlp?=
 =?iso-8859-1?Q?iaCIOtuVgxIrTdUbxwdAD6scz7Yw4pwFWjj17sreNYmjGAGu/Y2MlxKTaK?=
 =?iso-8859-1?Q?3X9gNmEbDFqpbJpuxHfsePYGJtoHUg6hYb5o+LeEY5DkaTKbf70yWVk7jK?=
 =?iso-8859-1?Q?1siMRUKeua46UWarjkXNiTxNFacOcYAUL2RkNGHyiRoZiYu4reGY+U9W52?=
 =?iso-8859-1?Q?OazWSkVfp4SdI8L6lfLqeQ2XzFDPc2FR0PVHQlGUEySlNLqv0+TeoAOW+k?=
 =?iso-8859-1?Q?pr4Ivdvj1FMBuk9j7pYOVC7z0Lq7Bybwx9Rve+dgi3+kcAcc4vB/sBF3xk?=
 =?iso-8859-1?Q?CKNw2No6WmxM2KURrTekWCb2v2jzsYa6h3B9vP4UQv11k5Tlej14G5PlEX?=
 =?iso-8859-1?Q?FTFzMUE+I3zLb8CAtJzrrYgBv/3w2/qMRnxmWmPwL/cVPzUrHaUR1lKRKS?=
 =?iso-8859-1?Q?8lEp77cqU7w20NA4+/J7VhmdrcyetQffYRHnWFOjj6qMVphQ8rLwfYP7f1?=
 =?iso-8859-1?Q?NJX10bb1ITrUPmj3odiuQr2NW5LNqxFetrssRrIYgoBhMYUn248INeYj/k?=
 =?iso-8859-1?Q?u+/Z+FZ1oQurHNAmhtb+Z+w1dfIlw7clti3GyZ2FDIIf0qnp2G3DjzqJ/V?=
 =?iso-8859-1?Q?gMWbi8ooXFvnxCP2KSH1rrgf9fIgSCMD/zwwFYrlBcOD8mfjhdXJN8JJqD?=
 =?iso-8859-1?Q?j+Dqjc8uo7aqCVzKHDXm0psxhBMp/os+xFTqgbpZuC7Z69w3XuBRm98sKk?=
 =?iso-8859-1?Q?EQSigx4Oc7d3Bvmcqu7L7WnX2RjYVBGazRMHsuVJje2MLyKKcBZiBJ4fPn?=
 =?iso-8859-1?Q?+mGgbYjcx3pRAoLIhx+zQFeH7T5ONH3EtvY5X/ngmUsga0EWz6js7lnIaL?=
 =?iso-8859-1?Q?hiBd6tI1X/Xo7cx1XFCOLEF05mDKN7T5vBuYGBmeA2FmDbdWGoVgSFRjU9?=
 =?iso-8859-1?Q?4mTSqlZRcU1eJYG6KvUXHgywRhuJdE+ekdp+AWSgMrjIgrQ0S2geDjQ5XB?=
 =?iso-8859-1?Q?Npmjdt7/y7fH2nAyxtsY+2b2l94NpXNEHxXgoGtQcWqlC5TZaxdjE05rMW?=
 =?iso-8859-1?Q?SA+YgHuGjFYMLbjepXJ+E59nHR1ftqe9Poe2hQgaVPR0cMM9okskcxxTpS?=
 =?iso-8859-1?Q?veETTT0pUzcUNNuWyMNVUt6A7UPBU9K5iUv3ocsj79uHhqLaJbJxRfsiGY?=
 =?iso-8859-1?Q?ACYh0p6MsJz7bVR1wVaW0aKy1E8IWaf1kyDVhSO2ejhJ723b6FAEJnftUQ?=
 =?iso-8859-1?Q?n2FkS2vgTk6zaw9U2U4yP+xCHLvQdDJFIm6qop7RVFVmJaA9w+skrMOzxN?=
 =?iso-8859-1?Q?8JQsFeklPnlgGCLAcLa0iHjPthW+JQfv8Ok3Bd6DgAtqpeuC9B/I0PF9n2?=
 =?iso-8859-1?Q?Os3RmcT2GjfrBfIEaoJ85VbXCT8tySS5G0WrYom5VSqv+a5yS7iol3j84Z?=
 =?iso-8859-1?Q?fXBwx8aT6Cdj9VYbWYSCHpR47sFC7MkcPV3epUiM+waRPVIavGEvO/fKIA?=
 =?iso-8859-1?Q?62fRWwyoH1Drhj8aodv1MP661SB3Ti57zfdMDuiWvlrdW/06It9bfNGJ5P?=
 =?iso-8859-1?Q?EBL47aSuL04ppc4jMCZhKGk9nFv/9K7bHzgDEbVtRreMlCmL3srawS7zVC?=
 =?iso-8859-1?Q?lPN0SAubJagBTdPeLcd+s87kOu0yQIGLByoT575WVNQGwGQX/DxIkfmQmT?=
 =?iso-8859-1?Q?izvHTuvzH1GA/ofMDrZclO63dLbzDBEwvx4GJ580gRS7d/PVRqh2MqFqwz?=
 =?iso-8859-1?Q?KEX/pMZiYyYHQPS2Jlx5i/7pTM4hope1iN0iyUE31mqj8ZsOH579N3jT25?=
 =?iso-8859-1?Q?42wiTCbdng=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rrnbl1XaCv/RuA1b25Le27h+YNtiys1cEZ/94GwLOtAuQPcB+KA7Iyke/RwjQu+ZSwIPtZ05RI995JBOdozROm3DfEIqpyFAfwRfknan6u+6TZxJge63LGWjU4x+3GE4co6V4ikx3SKpy+ehTbIgs1SwWPLOTwiKX37pPx6xoNq1KCVXt5Tx7ajCdM25yffrvD83bwKsANhiDLoVkzh5IJVCKdsEYcGmk+QQW2+skztLUKPXKfYPr9m/wueKi8LARRPViG7usa4ojF6zlmYxlNRMhJH/zGn2lFEXhLNopYI4ugWsJ63wZHBjawecVswaK3nvQh0+paBfbLeZMAfKNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53aea3c6-2d55-46e9-6b70-08deac0f4dc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 08:04:46.1860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvXl0jHmjrmW3fx6STATgrPU+rywTGcGRDu7fnocVaHB71uN+sco+qBTO9SuggXwIg9GNjkm91FCtV8n8VsGAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5915
X-OriginatorOrg: intel.com

> From: zhaoguohan@kylinos.cn <zhaoguohan@kylinos.cn>
> Sent: Monday, April 27, 2026 9:21 AM
>=20
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>=20
> xe_vfio_pci_reset_done() sets deferred_reset and, when it manages to
> acquire state_mutex itself, hands the cleanup off to
> xe_vfio_pci_state_mutex_unlock().
>=20
> That helper already clears deferred_reset and runs xe_vfio_pci_reset()
> before dropping the mutex. Calling xe_vfio_pci_reset() again right
> afterwards repeats the reset handling unnecessarily.
>=20
> Fixes: 1f5556ec8b9e ("vfio/xe: Add device specific vfio_pci driver varian=
t for
> Intel graphics")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
