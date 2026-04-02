Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB51F151C;
	Thu,  2 Apr 2026 23:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775173593; cv=fail; b=qFCIDQEqUI0t5eetI5eg0JrOWBgMp2Gy6w+0cmARy94Pccx2SDzf1Ayf+wqD+hJPAxongQEVf1oUcmPwUJk/EJiTGqI4lpZ1t4nQ/IGTlVj/4GskEF37bRKW7PMSr1lGNdhU1YYGrw6nhxEpCqDMCGjoER7s2DIqpdseWt4AU88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775173593; c=relaxed/simple;
	bh=InymFp9TPPU4SBH5BecNKtzEmtJETSI7uxkiGJFJ8UQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KU+D4hYUSpimp2EZKc4+grciYtt4F5nXH+Z6QloS//4iU65yOvMBF0slvPzvtJIMDfUCQTZrDBgwjlNZskhGRGqlJXiq5D7lm1bzgLBoxYWVE9t4fRqyH5i9D+kcAfKMaVZhLfNkxJ6hik9nDpbVk1KvpHZmafurqU5smKAuv3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyxMv5jS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyxMv5jS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775173592; x=1806709592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=InymFp9TPPU4SBH5BecNKtzEmtJETSI7uxkiGJFJ8UQ=;
  b=MyxMv5jS16Thr+RzUhOCKLCWULOt8MEtK1yu716k/8jZanMd22JyT3U1
   AqSiNU63g0S9LwL1MXgZ8rMQaswPgD8hAi3YgP5WmtimZVO3ElbZoAE/Q
   doHaMYCfeTMuNj1iAMIy9zWzsFwPehogfxVtZiSbahSSlmeC1gV18sXME
   8cvMdg7Hptbz8CyeQYjoFZTg4RXJT52cccUoZgKii4vlyC+6kIUoUxerF
   /3Fnmdo/ZL6w2qSlK+acBhNs6RiwRzcdb8xVSuNb1LuMcfZImwymNve3l
   d7r/BX84CfXIM/yYYSltFRsTTmwVCswOBAutY4Ml/jmNAKQw9NivgXqRz
   w==;
X-CSE-ConnectionGUID: STS7paqWSKS/Ny+8DJoULw==
X-CSE-MsgGUID: Rx6uo/dOScSmv2v0nh039g==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75413230"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75413230"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:46:32 -0700
X-CSE-ConnectionGUID: vn0YFjDaQcCItAYllL393w==
X-CSE-MsgGUID: TXjpM6EvSRyvwWI7nh26Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="231915913"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:46:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 16:46:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 16:46:30 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.23)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 16:46:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMsnfQbxmRX0NkKM+sVLfd6VU5DUnNiYDAACwP+CvsTtXqoL8dqQ/6txhHThH7jjBNfgEBO3KGYp31k0NA5nOGppgrPPx7fQSsJRAOqdlA8kTAOPzXJm0Rx6+z6WZ3mIBDGCnhrlG6OKVK/iLmCjjUkemJptK/dzq/sUcBxJcwD4g8qxS9zUyQ9wGy8OZakyX3cee5hoanrY1eaBiEUGvu99Ys3jqxo6w8XqV/ghcbH/3UE8nGlJvPSHOARFAZtuUwj5VqxPDVn5hRL0U1tKfbjMwXS1cPXzLf/aUdwvMPvS6He6oJwGzzrK3GvpdMQBSm9SAyAg2nKWXtaSylJ6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InymFp9TPPU4SBH5BecNKtzEmtJETSI7uxkiGJFJ8UQ=;
 b=iHXvLU9zW5grYikN2jSM7VHN3cSs5aJ9IqoGul5VUrbYgC2+M187svr3Fakdey3iLs5swPc1prz4BJv4Q/Ip3DnT68C9WgGTHB2pCIrqdPHqsk7hq88V+KOrVBkhUAzESYKZnQJPCIi5kReu39OePW8i2IHm1Rh9dmfBnI5ZttgEg8qqxy6lD156kAlO4Aday37iUfn8Qc84Buw2dg7d4s2137++/0Tx8gI2k98jKoiDw6q9q2oWdKL8kuXbfbph7vwxtFngA1y3K/0wIqWbH7+rW5mEsSqCD4EwG7Zpm95fcJxdOXX58HhoQLaTK82iEmId+Az8274zA9aN8a9PUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7488.namprd11.prod.outlook.com (2603:10b6:806:313::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 23:46:23 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 23:46:21 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Topic: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Index: AQHcviZXKVkTxmL/NkWOkEaa1Zh4L7XJ6F4AgAKRJoA=
Date: Thu, 2 Apr 2026 23:46:21 +0000
Message-ID: <2b1d462bfed958e163eef913a1149a807453892b.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
	 <aczYjEVkva3zOpwz@yzhao56-desk.sh.intel.com>
In-Reply-To: <aczYjEVkva3zOpwz@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7488:EE_
x-ms-office365-filtering-correlation-id: 7be1e625-630a-475f-7d97-08de91120b5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: m782jjG35spSetHEjdDyUE+rIHWvZhVOO+OpR5pACPCSyBQUTOpqHYqj330lGFAsYPiQ0g47jklDaKrVOqLUmorXOpvgYBHXEznFnQS+0tHuVCHCVTppR8wQ7Y2ZssHNj2apgp2Qzp/4o4si8QKrSSzXDaYaedD8nr35nGJevhbN6JoQymDGEqqktfqOIwONs4wYp1q+qN7nHRixdB/WCS47hvyp6rYvsoBrasdBGFvx4EMe7LiER5UOP61SIAG7ENVpX+79d6RfwqFQ6oB2ril6URPN7+kPHAVr8p3ua979ZZe2+nMCdiPzBLp4RFTz+hP0O0L4MVTWiQ0Aw4Rj9n6D0SE3n1eWqyLvJ8okorsUtz3wa+nJxNvHc7lhAFqtM/F94b6eQaG6QxHshyNzZYiS/4B3nLBOlc8de9vDOnUhxmdCjN5TaNucLCo6/YdSJzaV5g0zBsY3XSMjC/QPq8z0tYt4skQDp7VOgeMOaCnTnzM+ttf3JARriNP0J3ByHriqMvaP9EJrH7uoFEVlKIEkd1/41Orm1Jv6l49v9kflylTIvY0XtfyGipeI1e4C4lW5mH+mtXLMAYvlhGq/ob6TSJtEKWetIVYnKH320uBG3Tv9zTxj5vz8jV3deoRcacUasEwad5nDXVxD0Jh/ZVCWVfiPwz/1omoHY+YP1QHraM//WihQr1zQZM83eN61+4lBbIHPrAoQ4feo0uN6dstCnDZ2NAFbjKosgDtiTB0jLUcGvKXmxORv+I00+kAzWTTtN5CI6RyH5vGp4kfAyGUbg+nt4s4EmoGNc4nB8Kg/GHT5ZdmVrFoI6I3ZUTtW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzZ2a09pdVRBczFoa05vREJNb21rcGNya29DODg4UGFWMm5EL1JEOStjQkpF?=
 =?utf-8?B?ZEQyeEVuQjkvWmhxejIrU3ZkemFBNWxiZzdPSVFHemdPc1p3YmVBL2tYczVi?=
 =?utf-8?B?dGRBeWFkUjFnUnRGdVRiWkR1QmtzKytqS1VEQ3MrMUE5UTBKVGltc3RObksy?=
 =?utf-8?B?elA2NXBCT2pPYzZwT0ZSdGJoRGdVbXc0c1RaZytjdUoxVmttYkpINFVwZU9a?=
 =?utf-8?B?bGRDZktzc2V4S3NMZ0VTQkV6Nmh6ZzZSS0hoV2w1bGpTSDNad0Z2MmxQZ1ZC?=
 =?utf-8?B?S2dxMmJhUW5qbmlGT1hIT0VSSHVPcURZeWlERnVpTytQZFh2Skl2L3l2Q0hj?=
 =?utf-8?B?VmI4UVNHREdrUG8rSWZzTWh2NnVnR3NkNEw0OXE4SUw4M3g0QXNCUnZieDlX?=
 =?utf-8?B?N2NwMVZHTis4TUk4YWNJemxlTDBiQXBEY2hOaHZQK1k1d2JJckt2WXYwL3Qr?=
 =?utf-8?B?QnJObytZMUo3bG0yVjg5VlBOcWFldmtWQUxjK3N4YmdrTEZNeGMreFM0M2Fs?=
 =?utf-8?B?Y3IvdkFLOU54N1J4amxhK0taR0x6OUhTZHg2eUFjZmhKVG4wSTZvV1lPNFpj?=
 =?utf-8?B?NVhlNzZ1MThTS21FREpnUVZlZlRvTFA1S0lFeTUyaTZXREFaZDBUM0o1aUUy?=
 =?utf-8?B?QTAvcFBNZUVkbEtqNG4yTmU1WDNMajRIajhLd1QzaHR5SytPQ01uNDBtL2t1?=
 =?utf-8?B?b3gwbkRRWWdtdlF0RjlkemRFcDc4TkVWbk5EWDR3UXdva2xZRlJ6T293UUxP?=
 =?utf-8?B?dzNrcXhMNjdTUDVXUjBaNXk3Lzk3M1hYZGpmZDBQWkNTamFWQko5OG5qNTha?=
 =?utf-8?B?eEJFVlBGYjBBbHg0WklIM21mTFZYOUtrNVAyVnZ1eUgyeGxjWjZRZUZSNWVl?=
 =?utf-8?B?SDBmaGorT3N4amE2TmZJMHp0dkIzRlVTem5tQ1FqSkliZHNOY25tK1VqVUpS?=
 =?utf-8?B?ekkrT0dlVFViclMvaE9CUVArWFRhRno1TlRDSlZQL2xMc0ZId1F2ZUFLZnRT?=
 =?utf-8?B?YzVnZmsvdVFmWFk2TE9VcDdtcXpYc3VGVWg2NHNIS1dWTGVQRjB1WElPMFlt?=
 =?utf-8?B?UWRvMGNiVHoybm1vaGF2RDJHNmp3bTNqd25jTjNqdHFBWmhvczNuWnJmMzZW?=
 =?utf-8?B?QmYwS0FvYzcvcFY4ZmNXeGVOSDlTNnQ1bDI5Z3N3UTNwWkVFOSs5TERCMW1B?=
 =?utf-8?B?QmUya2xpaSs0MlQ2djVVcTlRZzBNQnNJNVFIdlVxRGhKQVhkYkFlRm5pRTBj?=
 =?utf-8?B?QkRSV0wrdXpXQ0IwUzNFMTlVb0sxaGhUMkpYdnR3WmdCTUJQcWdmS1B3Z0Jw?=
 =?utf-8?B?MHM3ckJDaUQrWlRLczA3bWFpQmlQamNPVTh1NWNTM1ZjMnJvdnl5K3pXNHpr?=
 =?utf-8?B?b3QzaHJoMWxYWTlKMGE1RUZxLytXdUY0L3VFZS9xKzNmTzNldEN3T3BxSFpE?=
 =?utf-8?B?NUhjWlFzWDZRODU1R0lqV1VQQlFabXZPZ3BmMFhwT01uZkZqWU5kZmxnU01V?=
 =?utf-8?B?c1NRQUl2Qm15NGVmRE45UjBOd2pXWE4rUVpGb20vMnpFRU9iRE9MOWxpSEEz?=
 =?utf-8?B?dXF3MjI0cVRxSnV6eWx2Z0xSSUp2RmRpclpGZHVIQi9uS056SFV3MmcyT0Fq?=
 =?utf-8?B?RUxuVUVhbXVTNkxGcGZBWWk0VUdKay9TUTVLL2ROcDFJWmhITWtmMkZ4ZENn?=
 =?utf-8?B?a2hYQ0xGODM0cnBLREdFSWc0L0dDZ0JKMldRcmd6Rml3VmNnd0dFL0lZeHRz?=
 =?utf-8?B?SlE3TjFFQ2lQVmhVT2ZjM0RBSitDWWQ0K1pvYktnL0loMWNSSDB0TEZiTE9w?=
 =?utf-8?B?RXIwLzdjR0JVRkJpdUxrUHE1THlYdUFJZlM0Q0pnSG1GalhMcXo5RER5cGFY?=
 =?utf-8?B?SklGSjdrSXA0alZVMnR0RC9mcU54T1phSnFKRnNscG1LeU0vVDBnTmpSMkdl?=
 =?utf-8?B?eGFaUjhHRjRhUHEzWFFxQUhSSkErWS81MDkrRHRucEVaTnIxSkJtQkxPTWRN?=
 =?utf-8?B?dHpXaHo3TzR0R3ozVDdhV2l1eTZCczRQUVVYTFhJYisycTdLNDFTUEs5S2Ux?=
 =?utf-8?B?ajJKYVh6Wlg0MStkREVjUy9UVzZBVmxwUG9pZ3J3MkZpT2g0MnlVRWZaUHl2?=
 =?utf-8?B?T1ZnRGZ5TW1nODRHYklNakJkWGI0K1Zab3M2bVlrK2R1S0V0QlJCQXJ2ZHBx?=
 =?utf-8?B?UFpvSnpTaGhqZDZyMnBSK3VmSHBZSXFFSElrUDhLQnFKbHVpWlowK3J3Q0da?=
 =?utf-8?B?dkVYWURFd1RDSmtpMTRXNkt3V2RZalh1ekhEbEFtUkhjWWVrSzMyRCtaNjBK?=
 =?utf-8?B?em5sTXpLRXVXcnFmZWFEdENQYnRBcDJFVUtyaUczbEJrY1ZaeWlsSTkvMXph?=
 =?utf-8?Q?BEHFRHyU7+cC/dOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7857356F69F67D4DA8441700C8169369@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PKe1JzZHTBK7lmlcbc++VN4s4+AocFwCt5UNE5T8Z4dAoUlQKZwlrKgoYwZd5CC5NXRzsunHqdKw5fYHf9JEYcFXSjodfqgoFcGbnobxL+zyeN8HVOlvfsKTd8P6XspZAZOc+r3hNf2a2Yqukh0v9LQGdBN4HdhdnncVdnqxm0goj+ep+vN9Y3baBi1rogVDTZdg+7vhLkHc9TdmVpHeY/CtUEGQVBt4kRuEWWsUQ9y5yNRhXg7Z2B2sDMmOfqkY5a5D6DF17w0BlzPQQ8OVoyDLxLBCIqqZCRTzDW6LB0yOJQGHZoBNiUo7EYD1rVXT19tyMs8TXIJ7rt2HnlUOMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be1e625-630a-475f-7d97-08de91120b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 23:46:21.9171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOGR0qV+0DEIzHG9hM8qWXT6zt0jMV0pvsQ5uX7CgefSY9Cbd3ybNTm5J9OFSTAh4dsazvVyPzmedJzJs0d+6+x1Vrgq9z5SGQvNIZ7eBRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7488
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDE2OjM0ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gSXNz
dWUgIzI6DQo+ICJBZGRpdGlvbmFsbHksIGlmIGFuIFNQVEUgaXMgYXRvbWljYWxseSB6YXBwZWQs
IGlzX3ByZXNlbnQgZXZhbHVhdGVzIHRvIGZhbHNlLg0KPiDCoEJlY2F1c2UgdGRwX21tdV9zZXRf
c3B0ZV9hdG9taWMoKSBsYWNrcyBhIGZhbGxiYWNrIHJlbW92ZV9leHRlcm5hbF9zcHRlKCkNCj4g
wqBjYWxsIGxpa2UgdGhlIG5vbi1hdG9taWMgdGRwX21tdV9zZXRfc3B0ZSgpIGhhcywgZG9lcyB0
aGlzIG1lYW4gdGhlIGV4dGVybmFsDQo+IMKgUy1FUFQgbWFwcGluZyByZW1haW5zIGZ1bGx5IHBy
ZXNlbnQgd2hpbGUgS1ZNIG1hcmtzIGl0IGFzIG5vbi1wcmVzZW50Pw0KPiAiDQo+IA0KPiBSZXNw
b25zZToNCj4gVXAgdG8gdGhpcyBwYXRjaCwgdGhpcyBzZWVtcyB0byBiZSBhIHZhbGlkIGNvbmNl
cm4uIEJ1dCBhdG9taWMgemFwIG9uIHRoZSBtaXJyb3INCj4gcm9vdCBpc24ndCBhbGxvd2VkIHll
dCAodGhvdWdoIHdhcm5pbmcgb24gc3VjaCBjYXNlIGlzIGRyb3BwZWQgaW4gcGF0Y2ggNSBbMl0p
Lg0KPiBDZW50cmFsaXppbmcgYXRvbWljIHphcCB0byBfX2hhbmRsZV9jaGFuZ2VkX3NwdGUoKSB3
aWxsIGJlIGRvbmUgaW4gcGF0Y2ggMTUgWzNdLg0KPiBNYXliZSBtb3ZlIHBhdGNoIDUgdG8gYWZ0
ZXIgcGF0Y2ggMTU/DQo+IA0KPiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtLzIwMjYw
MzI3MjAxNDIxLjI4MjQzODMtNi1yaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbS8NCj4gWzNdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8yMDI2MDMyNzIwMTQyMS4yODI0MzgzLTE2LXJpY2su
cC5lZGdlY29tYmVAaW50ZWwuY29tLw0KPiBbNF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjYwMTA2MTAyMDI0LjI1MDIzLTEteWFuLnkuemhhb0BpbnRlbC5jb20vDQoNClRoYW5rcyBm
b3IgY2hlY2tpbmcgdGhlIEFJIHJldmlld3MuIEknbGwgc2VlIGhvdyBpdCBzbG90cyBpbiB0aGVy
ZS4NCg0KPiANCj4gVGhpbmtpbmcgbW9yZSBhYm91dCBjZW50cmFsaXppbmcgVERYIGhvb2tzLCBj
b3VsZCB3ZSBiZSBtb3JlIGFnZ3Jlc3NpdmU/IGkuZS4sDQo+IGxldCBURFgganVzdCBoYXZlIGEg
c2luZ2xlIGhvb2sgc2V0X2V4dGVybmFsX3NwdGUoKSBmb3IgcHJvcGFnYXRpb24gb2YgY2hhbmdl
cw0KPiBmcm9tIG1pcnJvciBwYWdlIHRhYmxlIHRvIFMtRVBUPw0KPiAoYmVsb3cgY2hhbmdlIGlz
IG9uIGNvZGUgYmFzZSB3aXRoIFREWCBodWdlIHBhZ2Ugc3VwcG9ydCkuDQoNCkkgd2FzIGFza2lu
ZyBZYW4gaW50ZXJuYWxseSB3aHkgdGhpcyB3b3JrcyBidXQgU2VhbidzIGVhcmxpZXIgYXR0ZW1w
dCBmYWlsZWQuDQpZYW4sIGxldCdzIGZpbmlzaCB0aGUgZGlzY3Vzc2lvbiBleHRlcm5hbGx5IG5v
dyB0aGF0IFNlYW4gaXMgcG9raW5nIGFyb3VuZC4NCg0KSSdkIGJlIGluY2xpbmVkIHRvIGtpbmQg
dG8gY2FsbCB0aGUgY2xlYW51cCBhIHdpbiBhbmQgbGVhdmUgZnVydGhlciB1bmlmaWNhdGlvbg0K
Zm9yIHRoZSBmdXR1cmUuIEF0IGxlYXN0IG5vdCBnb2luZyB0dXJuaW5nIG92ZXIgcm9ja3MuDQo=
