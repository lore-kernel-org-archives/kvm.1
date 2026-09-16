Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED737A4B8;
	Wed, 16 Sep 2026 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541924; cv=fail; b=aDTO6ar4GccGZTLXMXwgppuqOfXc5K9oPYlOX1wWdmW/mtfY3Kq0kgChBjLQEmg4oi2pwGZ6VY6LahQW2YQpDrvLrCq2fAnW2/cm1xaW2ZLtReqXlMhHiwwWoW/V6hLApR9jOyG5Iab8D4Uk8AxinjX8i5b1TP1qj/5dC0v1uh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541924; c=relaxed/simple;
	bh=Zvlv/Q0xQ3JZqJervdGI9/2DVv3FM8XojnLFPhcYmeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QO7dDUev/UY7WiG8FigrMfl8adB7dn6MUVM0qHMWqxuPaWPtkuv2e8/KHYHgIUHMt7g9KZtgAfQDs4beG95RXMiVXOw3E6msA57HeAS0a6nMMefztQWJ0GbB/yBQ8pkWqru/HS6QRcWLPbTgUi0EJmu4qGMwXiPKyA6/OzfyD8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEgH84jO; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEgH84jO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789541921; x=1821077921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zvlv/Q0xQ3JZqJervdGI9/2DVv3FM8XojnLFPhcYmeo=;
  b=PEgH84jOeoafH4QjKLxKTqx1eRMFf6BgLhFa33TD+oBv5bwdsu9ezjHj
   Dfcj47Tj2mscmFo5AHTCIQJp9O7XSQwpdgFKR3/+cejlfIp4guUNZbLe5
   YlnKEMz4mLewVIEhhSK2f7YFMtfqgGD5NtAe9uG10Qflx97B2673JlTpS
   DMBUd3cV04dGM+/c2MIoUhaXhKL7bBNGDGwtEG639BRFxXgrjF9J4fTsG
   YYdPBKOJITGpGCapCOgVWdFQxXW+tLz+NI4J3tmKH9CFdDwBB+LS+luPd
   IeRK83aBAng/aDqz2GKn1NUFSnE5iqQEuLfTOPRAfmux6cc8CNeQ323/e
   w==;
X-CSE-ConnectionGUID: Yf2WgXBQRr2b0OvWyw8gIQ==
X-CSE-MsgGUID: g4cCsamtTbSpwO5QXzgI9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90047310"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90047310"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:58:41 -0700
X-CSE-ConnectionGUID: fPx4NU62SkauJgKZlEzTwA==
X-CSE-MsgGUID: 3IGIM6VCSVyBmTrN2Pl/JA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 23:58:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:58:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 23:58:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 23:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByxGiADqL9xdhvKdA9hJ2sc5gg0LR69L7+CMdJO3ZdhkzRVLsYjbX7lzUtlSMglS0jhLdQ+9H/yTGOC1D97FGO0n9W5PRdJreH3/aELjhZ4x3BXVooHOp8KiJC40mpQFUAZcuxMM8Q0YU2VvPtFQKoTubWv2Vg6mmY2e5xCj8+rZ4CVPtO+Dx3mf5lOBSTsG0isZn9m0xNn89HEH9anCCfr8IHUoXWuxVPA0VOqNPpZJlO0EYWnHUW+yVsfPVz6oVNM8lWkmUvwgrwNvp4l7BVIXb33CdRcLVCIU2x43YPyhoNa5Kz/TMyGtYaELPeAdDakTfPjbjaYJB0FULVMSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANzz6C/t4jHQjhWuMwduV87ETlXqRdYwZ/JfFknY15c=;
 b=xsolB8u7UefN44r+Ejy2c8ZpzFIBVUCvNG9QGWkWT1tqcrvwoPB8ygksyHCk7wCughRXT9jsgCTO5XtL3cFnceM/L6DwurxoCF4wnWsg43DdQ7GfK45qOnyenOjmkruDauG4ytfmPTugcObhGuFt1crYBStugRDhgMpjsGxbKUNYOAFHA4uHv5jzSlbbCtp1AAkCsDobsEC5nQOknVENFsRhtmO111uqTiChhZFE+A9sxI7iwyz62VkK7JxdznXvlVXbLG0CY0XfmPExx+Vp5ARKw/XihJg1gTL5ObxER64EqPz4rUN9VFrtovxEide6bTcZKeCbMT3u278PUWVJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SAWPR11MB9545.namprd11.prod.outlook.com (2603:10b6:806:4e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 06:58:31 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 06:58:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, kvm <kvm@vger.kernel.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Liu, Yi L" <yi.l.liu@intel.com>, David Matlack
	<dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 1/4] vfio: Reject a second cdev open before mutating
 shared device state
Thread-Topic: [PATCH v2 1/4] vfio: Reject a second cdev open before mutating
 shared device state
Thread-Index: AQHdQg+0u/YNUN5zTk6ovPWC2RcDlbbQzVAg
Date: Wed, 16 Sep 2026 06:58:31 +0000
Message-ID: <CO1PR11MB4835597EED00BC9A00827F1D8CB92@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260911170429.1642480-1-alex.williamson@nvidia.com>
 <20260911170429.1642480-2-alex.williamson@nvidia.com>
In-Reply-To: <20260911170429.1642480-2-alex.williamson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SAWPR11MB9545:EE_
x-ms-office365-filtering-correlation-id: 5f471c7b-6043-415c-860c-08df13bfeb4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: oGN2CJbTebpkqGmW0YaukXnQJzF/rBWudebMECqwZQrBXNbu9k58MSqtTaJuUaUrIbfQr5f/n1OgDFabqWtaWmA+F8I4JsAGiKAfxlJObHDdo6mL2bSZcM41pU6Tmz1e0p8oo2l9+OxN80KpZUJvi/3LMnWRgX2JJ5E5os9SMpWtPFqsvDdCelnr1iH6WlrCO0emGvyCaaUy7soweGjPmy4CeSKKiSSwZAjNc6Zr3lneXL0uVypYQcPfHHFM/BKeujSxOAK2is4mRj1iP2kI9VS613z3MDhMuRhKFlWSGAx+N+Otuov18wGYL04lnC1Ymo61Yk3S1UHDtJOPD4tTjWj4hT/eiUeqbuwrr8ZvN89ATH9aIBPPH6DgbT0oUlOVI1Yv0Qb30ZOgKA3jHZ9w/OQP/ciVY9U+NZ1wR/PIW7lXHC6yS0+bfJIavW33kSDz/ktqHhSO8BlXVflnCs558BoCw/RM1efYdEyN5gDLGRgWrXVUQF/wkxtx9PQ8qy+1y4TooDpBDHLZakteBUasn/Wqggiyx7mZDAwP/wpS+AVxtD0v/j3AtTJkgCUcmmVNZfUyh3aGmuLxn0fdTS8HylWzuvH0rHLERccavL2qJ9vHC9zsiE4we/L6e/di61XSfE2MhNTLXeOikBA8zUyp+X1hhOHEMAPeixKGMXcvV9M9fN1OZnIC9o7Uk9JPeoqKttCrXsO+nw01Ld7fCVxw1bR2A7/oI2hMTz1NUZLeNxo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zMNgpHO06uIsZnCbo1yQTZx5HKHv8Aes1H4ZlbFJYHpOjLtNt1i3HIhuiOuZ?=
 =?us-ascii?Q?9tOTKYdK648NCVfBwbpeQetiMCvhA8MaaPVI5b6LY18/cnqGdZplz1pFPrPx?=
 =?us-ascii?Q?osVNrJLc6CCxAoLDAf8hCvF9OYX+ryhMnUUe3/+Pp9z+MQhKoN0Xc0rbES6d?=
 =?us-ascii?Q?B+fMBiuleVRUoF6GyQcQQQfc8OIgFn149pOXume841qlUQBw85C/FsS/CkNf?=
 =?us-ascii?Q?eZ7HC83v/yE9PEZSxQth5BrFqhHEGTLZdXLh3HvH3b/ZqmCSDwWYwpXPykjr?=
 =?us-ascii?Q?NR7X90wADeZbkcI7JEVrCVsq/5/tVgS3dgge7pA0odKFAgBQXsVOOj+95ftE?=
 =?us-ascii?Q?phv9NrV8g6cKfEwrDp6uVB8zGNrbcfORyPqtRNylxO7F1I0nZiYdfu9teUGS?=
 =?us-ascii?Q?MLrLVFH7vKucIciry3bppkzB+/q05kGK8XDscxB1zx9YdToqt+2A9tpc0ZBk?=
 =?us-ascii?Q?w1EKD/VCSEs9OIGDiKfdSDNL5EW3hwaQqu1rl1uo+NBOQOU7yB6kcB1sTdTm?=
 =?us-ascii?Q?i7gtK8O8e9ZbwBD9ZGEDWNlcam1PWL5sJZSP6SEZ5wvmmByfhnv2WoTY/2e9?=
 =?us-ascii?Q?fEHzeVl3gD7n89St3kHVoPTohpl7tUGDuwg+0IZhBtvt1w38XDhwU60uV0Sg?=
 =?us-ascii?Q?U/wenMWrPcJKNxZXmcZrhYx4H0wgE5KQDrVhVU4uNgELKmOyOj4IGEsrrV5u?=
 =?us-ascii?Q?Q1DHDCB0tRUQodaAnwePrepEubI2fCEuAgLPlrV5l1xcWjD8/dUHLaHxcyEd?=
 =?us-ascii?Q?qpRk+tx5TKNIGO6YgEZL617PMX8yP7NGpRVQZJwLb74lKUiXh+l37eUr1DIM?=
 =?us-ascii?Q?TEfvat5eD1LbWdQmYb+W+ygSwTsM+FgItvor/Q8rmYUXVQJONJx9oLmnMpWE?=
 =?us-ascii?Q?7Xdk4rF9DMB2iJhP7K9NPMUANPKJ2/0dUA9zpZe9DNAtU5ZjZKt/ooDtZAwY?=
 =?us-ascii?Q?4syJiiRu+kAR9hlM5UqU3TKDJio+F2e6EOeXuc77nqrSo+5xTyU/bOpODI09?=
 =?us-ascii?Q?HP83kgYIhZ8ruyaJHG+9Zd5ewP76z6W65IBhtoZksVGxCqtT3Y0PIxJlCmEq?=
 =?us-ascii?Q?Jxs0hxZBw7kq+aLlHOaR/7M4lqHfjY4UsnoFXyM82oZtIltG/7kpqfQtWdWA?=
 =?us-ascii?Q?lBAj0SFqiSNSIg9uoiGW6ZjCgQG59ZnKgB2XQW7dx5wQpC/lGa8iAUi5WY6U?=
 =?us-ascii?Q?fkJz6XwPOV5EcVKTAOqm9B40Te/EiGtwLDusjN7rMOI1FEGpZMI+YVgKWFRQ?=
 =?us-ascii?Q?r2VUVjnNVA9cJuBr47Lwl8lo8ncPHcVpk5kvN0kLKBMMQBBvIMX+WHqxP42j?=
 =?us-ascii?Q?4Guv+fgvxTXDn5l+shBFaPlA8+n6BuwrWL4xzMWPK+oX++sQmqhh8S1gBeO4?=
 =?us-ascii?Q?o9xtSkJseKEDf0X+ugan9bWMzZNs88wNGkmgemoaddeG3xJo5I6bUorGGPay?=
 =?us-ascii?Q?lBqXqgRWLI9wm83D9DCJwp9tenq9vEE4R+0smQN7jfvS4V4QAh1uCV6s6KFK?=
 =?us-ascii?Q?Kzxspaelk2y0n56NX10thi+uHohkn4dpv3KNzXV5mRnsVgEDXJcIkgOWgydG?=
 =?us-ascii?Q?aCwlWXx9DbpfyFwgvjnWYIcq68n1sYJ+F6W1x2BnOQY+qi/QSy2FbPSFPciq?=
 =?us-ascii?Q?OM8gsDcEQBPd72JK0Q65+2Pl9nCR7iST2iIhgg7V4wOBxV/Vzycqsvvmm67v?=
 =?us-ascii?Q?AS9pYbzJW3gC6U6Tn8xO62DOiV13SW5iKEDKVJ3i9cXIBc7HfvMjOzTluUBh?=
 =?us-ascii?Q?BAGyIxDoJA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yU0AQUP5EBKj6PBwW32hrMELXYPr5ECYBDKumQzp2Huw3Hm9XK8Ho0IHL8306MFSM0zZbURWvTBstoH5vfpL9JZGiCx0BrAqxas0JbNWgQZ+mxs/gRUqt7byXHvlLZlbxuT9DZX5oy+GXRWWljUDJQv3l5BaUWuuGArx0Ic/yIw843N5Jo7mcxppwD2JsrXV1tNcgOI9a+Lgk7JIbD7JQowpTwofp00ouL/CSw34xzMmP5H+mf3uiAk4caalxRSzPGAJ8gx13ZNpX3vVLKwbhhnJAfJp0G4nqtT3XakUVIH2+Y8BIZYULg9q0eneRNUlBGfI6/ODPhQwpIaTSt3ZrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f471c7b-6043-415c-860c-08df13bfeb4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 06:58:31.6770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fmkgw78Sg/fhTiTYmpmonxCJWvQAKlxLYSPivQrezFWT/7S7sKbLo0m/Ylu9966p2bm/F7av8NmF/vQHzcbhag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9545
X-OriginatorOrg: intel.com

> From: Alex Williamson <alex.williamson@nvidia.com>
> Sent: Saturday, September 12, 2026 1:04 AM
>=20
> The cdev single-open check lives in vfio_df_open(), which runs at the
> end of the bind ioctl, after vfio_df_ioctl_bind_iommufd() has already
> updated state shared across all opens: vfio_df_check_token() can set
> the PF vf_token and vfio_df_get_kvm_safe() records the caller's KVM
> pointer in device->kvm and takes a reference.
>=20
> A second cdev bind of an already-open device runs both, only to be
> rejected in vfio_df_open().  The error path clears device->kvm and
> drops the reference, tearing down the current opener's KVM association
> and potentially resulting in an unbalanced reference on close or
> premature release, while the vf_token remains clobbered.
>=20
> Move the single-open check into vfio_df_ioctl_bind_iommufd() ahead of
> both mutations, so a bind that cannot complete leaves the current
> opener's state untouched.  df->group is NULL on this path, so a
> non-zero open_count is exactly what vfio_df_open() rejected.  The test
> in vfio_df_open() becomes redundant and is removed.
>=20
> Return -EBUSY rather than -EINVAL here.  The arguments are not invalid,
> the device is in use, which could be a transient condition due to a
> delayed fput if the prior user is terminated.  This provides
> compatibility with the group path, where a group open returns -EBUSY,
> and users may choose bounded polling to detect such a transient
> condition.
>=20
> Fixes: 839e692fa4eb ("vfio: Make vfio_df_open() single open for device cd=
ev
> path")
> Fixes: 5fcc26969a16 ("vfio: Add VFIO_DEVICE_BIND_IOMMUFD")
> Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for
> VFIO_DEVICE_BIND_IOMMUFD")
> Assisted-by: LLM
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
