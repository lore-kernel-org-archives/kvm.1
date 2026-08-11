Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9BC421F0F;
	Tue, 11 Aug 2026 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441969; cv=fail; b=WiI7yLG4dnlVI2aSPI5pqZtlYVf3rYlvuZ8uWV4FKSSoR8T+YDKz7uf8IdVKm/4qQyb5TRpX38NAzOBVvHvkUyE0eZw9wqssTxvpKhrHe2jzBAafVIskfk8vRthitRW6UclzhnRFkH9nmyHvgQz1nnh8ozdlJgm2uCCcCxYGmj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441969; c=relaxed/simple;
	bh=C3YENx5O7d35kWMLocFB+0EOmvwV+SFU40BQZB1wPlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jM5f6KIlwpd+hmHDnXodULmOjtWaht/JjcPsEdk+t0FreAwMnNFjx2pbb42VQnqL4OXIbesPLHlS8GPCXP2l7/nJZgfzG9AIqVmmvmtPpZ82IBzTOTemzVGmwqjuHqqnpPOBHX0Xd753QbAFWX1BUezNlW136I3CwwvNM+SoQG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AV67RJJz; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AV67RJJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786441968; x=1817977968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C3YENx5O7d35kWMLocFB+0EOmvwV+SFU40BQZB1wPlo=;
  b=AV67RJJz05iLqjedpJmaJ82BW/4hSbpGS/75IufgWEHCnz8aaWUYtNDh
   KQG7AE7zcSChF7KUVFIrIRkLv9TsRDtoFUhP99Xl2Sx3iU3ISGH0eX2y/
   e3GNJwygD2Bwp5nHEghSPjal++x2wkJvLNDNicNX35dk1WtJm8x5A2hko
   c2mzcDq/BTnmYq3EH5adRpm3Wuujp9ielSwJaBkWm8IE6SXlAxXfWcx1G
   XhX6CnNjR9eRSZXi9OZ/jL6ybEBNQwJP8tCKILvNnp5r4oXI3P2jZGXKX
   EzrOpjRWGhKxkqI85hKRend5rA2oPQeQNE2uzjSMTnIQegYzMvMhjYtx8
   A==;
X-CSE-ConnectionGUID: R4XbFwfbTAO/35fe3Cvcxw==
X-CSE-MsgGUID: qkfqsTCPSkmBdWPDTzhrow==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86980931"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86980931"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 02:52:47 -0700
X-CSE-ConnectionGUID: 3gFvwSspRfCV+V+aK0xaOw==
X-CSE-MsgGUID: NPjnFKi6Sm2Ib3x8Gbw5nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="261535758"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 02:52:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 02:52:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 02:52:45 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 02:52:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8jnwD1nSWkHMqhAeHhbnubtPcpZFfpZ5Nh375irIdmY3KgXxC+k11Na2Wb2GreaKggHhdl91P2ganIXAwIBUUFYVIX3hKGUagdjAIUMw6NdsL7bKtJn4FYuj9nkUhshMbyiklJBZP7y4t6R2QOWz7OohW+ytganKcNwehoCrISN4Z5msuVquF1IBctH0rJjTlJ2kFo0ZeTZXzmtBVZ4+Mu1i8WcrcdUa7/IiMm3WTomO/e+UVtjXf+FOhIg47kSd1nPKd6jguvFUYLk8Ptka1+CrWSs+KKA31BVcocizMP9FOdueW+ODdlcx5PicYDz+LHrq5orABhDDifLfuqwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqN4SAjH4BrCsVEfxpTY/v70MSs5sd+lxfoSM1bxtGE=;
 b=BTPC8fYUtJdVf137ZzyzrdVIkFpmJpMFrYYn0hh6DapE1UpnNXoqB5Ly50DM+Jm7d0r/OmlOzKBJ+Ua/gjJIulPbwERjpSv2rM9QAJc61cHQ0n3uLg1+zKMjKZqNf2mebt/Y14gi2JlJ6KIILoIbskLJleAhzHrvOazDZ+OJZSnfEQf4krRaFkcZktHa0XhVAoK0+emm2ZBqiAfquKK+XOe8PG8I2BNsEVs8Z1mHwDeLBW1hhWirgxnBpisbC143t5SGnTy6jGnJiq4ovJ88BvwTBhlcbIuc7DYqkvzQHXkQCAyJKiCs493YC93Hc9oApHJHzUxqu/fMRzIvN3flVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 09:52:37 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 09:52:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Samiullah Khawaja <skhawaja@google.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Leon Romanovsky <leon@kernel.org>,
	"dmatlack@google.com" <dmatlack@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Thread-Topic: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Thread-Index: AQHdJHIqLrZtspdgLkq+Xyv4uF95S7aPjjqAgAHhwYCABgIBgIABLH/w
Date: Tue, 11 Aug 2026 09:52:37 +0000
Message-ID: <CO1PR11MB48350170CB4BDC89DB1FF96F8CDD2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260805003355.728299-1-skhawaja@google.com>
	<20260805003355.728299-2-skhawaja@google.com>
	<20260805090323.01b1a36f@shazbot.org>	<20260806194739.GH28508@ziepe.ca>
 <20260810093223.50dbc8d0@shazbot.org>
In-Reply-To: <20260810093223.50dbc8d0@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|MW4PR11MB6838:EE_
x-ms-office365-filtering-correlation-id: a218a15d-3406-443b-3f49-08def78e46b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: zCnR7wuvO3C3Pa/tsmLHZvz8hFywV6JTx5wKwKu9ixsAzoufj4Aoir/3vH0B383G+9Z1vqh4SPIPPdSdhtGsPzXNJZqCT3WA+kCWzwvz7h5m0Y1BkRqXPrQ4F1e2fIP4IFySNnMsnBLGqHGThjWY6dMytkepSe4yUijALROattPXLOnVUBv+3rspHvjwqMs6bwoYjizAR0yps1dkUSS9JDJYzpvLxBpJi6Jgs8aiuOrTKhpuTbWMbB4Huxe2n0EfW+JmOk5mrmV6KuEMC2/eSQmzVga/9hJQHbvNSnQlneeLjtAW+vkrWVelcKTJEecqqdDSyoIis9K/pH3f5m0MNAbKob78UES0RtH0aZi+HrJZY866U32kbe3H6zgTWCoK3O2fZaxB/rvcGFAWz9UDqV3bS8g+pvL0sA25oppIO9VDxznW1vh9316Nkhy9X4NcT3ECHqMB9iKezf6XqgN21c6WZtQNICFCsN673vSShbmHvvFv1kLCu20qrcr77KeJ1tIuW4DjZ2N+gDdsUFI7lEfnXvlvDKur+H4m6wnrhMzSCpdNIoudW6ZyWNs2hxlCG7Lrr4o4UzwhTj3oBp1FiE8/sjEte1yFBXKqz/QD4/BVm0OifN6dLElcdAp3HFKeogSYU0yJorokD7tWacFg7locpdIqp+N+jztPTZfa6tWK7SuO16CCyrrs2cVOfDIcI8CFxAbFI0asrmPIPb0T6lQmww/dmQ4j1pd8Vz5JEaM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2y8I0IEnxcBiTcAQnxNyqmD5UpCnDPc31mOgkVaZ12gU8RV1humrwZvxcq28?=
 =?us-ascii?Q?gWeLZqaCVXcoqWNbr5iTLVrBOvlDfu9zAWVTvSmuP1e4/idnDVvL+YMvsDn0?=
 =?us-ascii?Q?iDdBPWrC2kIGPDACWTkFTvraNz+RBPkLO0gDjMeMaS5nDKM3LF9YAhh5pbdr?=
 =?us-ascii?Q?urRqCJQvDQP4dPAmzY9oaj8ZLUE0ShOPToSLPOu7qa4q/uN7eqb+cqFvzEQ0?=
 =?us-ascii?Q?CFFwShnpC+ikqrLe2tCniDJYcQLQwRS0HYMo2lqt7ZSRWCuDsGYuK+sS6Uik?=
 =?us-ascii?Q?nZ2tfQWDEA4rZKDTq1yzX16kGQs2vkB1/jqDLuJV9PTbNBtNXBUICRgtP2NV?=
 =?us-ascii?Q?Yp8aFnpp8o+R1Zq1f0XCpY8BAKO6arhytKv3NEEZDdgquQ220+MRC8V3jmJ/?=
 =?us-ascii?Q?zyQtCuztHxBJtx9n48OSOSWrPFvGxIa52NadiAefysF8vNBZYdqMVkjV5ltc?=
 =?us-ascii?Q?2Gti7xjivzVS0swlmD5vCWdAoL3ECXvpQlBzW7w7lfZ7lrCMmwTPDITgGT19?=
 =?us-ascii?Q?/JhjuaTaI9+7q0G3YA+aYZD6OFjeQUjiVvO6b10tGsym8FVC6cR7FyM8unvy?=
 =?us-ascii?Q?2Yb4l3vGLaZghjCrBBGgxAj/UHaAptK1QzVph7DhTmqm2aMbeGg1ue7o8VAn?=
 =?us-ascii?Q?FSzTj63Yz7cVcja28RGRWab4Af1DcqEpHK47b/+q3kMTqcoNL0wNRTAiL0YC?=
 =?us-ascii?Q?lWnyesS1bUO18+3zvaQt6Kn4sYj6a31MFhTfWWJaFJNFrEj78kpW73NU76ah?=
 =?us-ascii?Q?0wymCTA5xQXQOhzEkyfnAnbN6QDGzYmMl9fxTNnVcJLY7JxmMFB6HUiNvLmn?=
 =?us-ascii?Q?KXFDMdMwo536wqMGT22USuc4Xefd7NpClJANyy4ohMXmhVGnJ4Mw81uYAw2e?=
 =?us-ascii?Q?E9igoPK675MZeiFOhItz7wxxb7oYr/PJQ1o3QPiT/cKfKVon94lmkhHReaZ7?=
 =?us-ascii?Q?4r/cGWTqFqcq2e9oAdf0mHvD1S8DwlYg3m2RTsuB2MyyY6sBX5waOZ4VTiB3?=
 =?us-ascii?Q?EbdTXmCbWn0WZr4ANZZenIff4axJezSqpyxycCWeFI+JK6SabKSURG7DHQps?=
 =?us-ascii?Q?tfWxN3rwUEAL3yRXYDz1b44rczRawlJCjTTVExIaK0zLq8OJKwwOOmFvHzVf?=
 =?us-ascii?Q?HBdSxTTmAyMoJC1KvDNm+qAEvqSNRwu+rrsRlHSINBEwKIP4v/DYCR+o8/sV?=
 =?us-ascii?Q?Mjy85cB4AAnujN/i+7YoHYSAo7Y1BxTNEpt1VBBfXX7BXC5bUu3Xd/1Fyzv+?=
 =?us-ascii?Q?hj2/DkssPV5YQsaxQhrcc7Xg5fsqbB3+kzcDPYHw2y2FotlGv5CthROHTbpb?=
 =?us-ascii?Q?8f7k6DyqxB7BDqMF6G/jGWsOgSRDqBkYwvnlgI/Vn/q2DosquB01EEkkBQjq?=
 =?us-ascii?Q?w6AyT84DDTolVLyFKdXRWSOBj63HSH7ni7rre/KII2HNUUt6aI/syqYf2g4k?=
 =?us-ascii?Q?qqr0hXGZlaT0eMPssifnBXvk7BzUOc3pswXzH8llI/Von8wwsl6rBZvtyp8n?=
 =?us-ascii?Q?5d3fp09kREzQbNZH3hmzeXWSNpbFgGIa2TJhbr74gcmDZVx9Slt6+CsZ6056?=
 =?us-ascii?Q?oxvqF/MZZj+/SzHml2ItakmzvJPU9Db4oQCWVPCv6sven9P4Y82wuBWgaTV7?=
 =?us-ascii?Q?dTt81WRtATTB1lSDZhhcmRJ5CN2Fbh9kAYBeVKv9agopPmry6/ZkeluYg2gZ?=
 =?us-ascii?Q?lOMQB7gROFh+NgTO4IVb8YIyyyTftfGpGRb2HSTjzudN1vQl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BOONdCaTcxCpX4T4la4UsS0bFS0maxSm3iGmFJzZvG367exuBHYV9+ysXmwr1ppjgOfwzXV8dGQ2KiXFvVLVehxBHF0BB/b5DfGXiNcHLaDK+mBItMrJTKEkyYOs4QP5Q6o7CquB0XexsMr5rLLgkZh4sbTkvyW5HAi0Azg046ZZsf+9mOU1zMi0Ijhg7d3ON1ZFi9VUA77Vfpk/uEaLhFda8bokOT1se/hsgIn1uXjANjGd5UD9JMIEe5Dlk15wdw/F5Tc/cO4qP6bR9BKISTblBVDWFE3hQh4050fg7HfP40TxibJ9Rdd1BLOzim8qXlfbGpmdxJ0+ZLay2bFYOw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a218a15d-3406-443b-3f49-08def78e46b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 09:52:37.6830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSzwOVOHA8xpJJmn8VDrMkgGGwhucuseWIndpvpgRK8++841IQSnfjvNGqeNjJwLO17oFTiNXrwu07EcPTvp7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com

> From: Alex Williamson <alex@shazbot.org>
> Sent: Monday, August 10, 2026 11:32 PM
>=20
> On Thu, 6 Aug 2026 16:47:39 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> > Adding the sriov disable here at least makes it defensibly safe, that
> > we do still clear the PF on close, and we don't take risks that the
> > active VFs will crash the system during the FLR blip.
> >
> > Though I understand it was not the original intention, I feel we have
> > ended up in a strange place with the SRIOV PF feature ..
>=20
> I think we have 3 potential options for PF reset:

Is there any coordination between in-kernel PF driver and in-kernel VF
drivers regarding to reset? At a glance looks that requesting FLR on PF
via sysfs would silently affect active VFs anyway...

>=20
>  a) All resets are blocked or deferred while SR-IOV is active.
>=20
>  b) VF mappings are zapped/invalidated at PF reset and require
>     coordination to be reinstated.
>=20
>  c) VFs are torn down on all PF resets.
>=20
> Option (a) is complex and doesn't look like stable material.  A deferred
> reset on .close needs to materialize on .remove or .sriov_configure
> (and of course .open), but to allow in-kernel VF drivers we can't rely
> on vfio usage counts, or even our vf-token trust boundaries, which is
> what leads to the .sriov_configure hook since we need to take advantage
> of every opportunity to issue a deferred reset when SR-IOV is not
> active when we can only rely on the PF state.
>=20
> Option (b) is potentially more simple, it implements the blocking of
> access on reset in the kernel for enforcement, but defers the
> coordination of reinstantiating mappings to userspace, which is really
> how the vf_token model is intended to work.  This is incompatible with
> in-kernel VF drivers, which I think means tainting on VF unbind from
> vfio-pci and those working outside the model would tread carefully.
>=20
> Option (c) is the more heavy handed approach, it means that a PF driver
> cannot fail or exit and re-attach.  We have existing logic that handles
> a PF driver re-opening the PF device with active VFs and authenticating
> the vf_token (logic also broken by in-kernel VF drivers that bypass the
> vf_token mechanics).  There also appears to be significant locking
> challenges in this approach, ex. the inversion of getting the device
> lock for SR-IOV teardown from the ioctl, config space, and .close
> contexts.
>=20
> I'm open to suggestions, PF resets with live VFs is very much a gap
> that I'd like to close in the vfio-pci SR-IOV model.  Thanks,
>=20

Before closing the open on reset, does it make sense to first fit it into
the coming trust infrastructure [1]? e.g. initially set to TRUST_NONE
for any VF with a PF owned by vfio-pci, preventing any bind to
in-kernel VF drivers. Then opt-in is allowed to promote the trust of
such VFs to TRUST_ADVERSARY, allowing driver binding but also put
it in precaution with IOMMU protection. So a malicious userspace
PF driver cannot indirectly affect VFs to do dma-based attack.

somehow VFs in this scenario feel akin to Thunderbolt devices...

[1] https://lore.kernel.org/linux-coco/20260705220819.2472765-10-djbw@kerne=
l.org/
