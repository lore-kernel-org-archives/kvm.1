Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85B382F04;
	Wed, 22 Apr 2026 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868158; cv=fail; b=GqT3kXYNOwONQhOcdvLmx6E2SaUV241/p5lvm4t3Lw7QLfTgZY6LuYna0qLJ2Vt5KliECvpWQATBDMAUWPD+opi7t1PVwIQvljTau0bWV2sLifQVxRGFrXcdGY9hBUdOvIFIzAYEH7WcCav5AWtw+F8f/pf+2DxzDzuugfvbhK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868158; c=relaxed/simple;
	bh=m3VAG8NtA/lk7TlfU2DixiP2R5SrtVUhrZpOklD4Bpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cP/Eu219h4juU3Q8AQgMxE20OpqzDw19Oe5xIeJKnwiDfCFtZVUxtfKayKVj8cu09Xs0vFigx1AUoYvQt/HItHDgeNzCTnrNlTMQi5FOnTWpN/BjIKgk7Opf+U7ED+YQ469T3+ImqBpzF5Ce753Cc12dtjiFXNYQ11CcbPZmIeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSx4kgbk; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSx4kgbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776868157; x=1808404157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m3VAG8NtA/lk7TlfU2DixiP2R5SrtVUhrZpOklD4Bpc=;
  b=SSx4kgbkH7uQOMxuoGCut4MqHNrlLoQ2O4Y3qZ/FTG4TO83teve9lluz
   HHKI3M4URDJMQhl3lNouVUyZufEh+04A24/DB6XPNm5zyuelk/TcHewr+
   TWnJQ0DxDUMc8X+XEfqx0Gj7dQf0+KhGHo+0zVHqrJxGkZEQTCXRXasO0
   u7lp2JQz3uP18JLuieaFaK2JxBKFMoei5nHQhTbsZr8Z7M86zr3wc/smF
   r0uVFr6XomXylWOqwfZKPZY4Fw9pJqaVJdac8AhqAxRKkeUOZVkJrXi2c
   5Ib5NAkXGWpAtvQZQZI8uCFNOM9C3q4sbtNu2jY/hq52edqHWr531mpWu
   w==;
X-CSE-ConnectionGUID: EaNIc1+6QXmsTDZvxQudoQ==
X-CSE-MsgGUID: hvXRys+JRUShtECCZIdrkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="95235933"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="95235933"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 07:29:16 -0700
X-CSE-ConnectionGUID: Iam0VdyQR4GGu9ETjAduug==
X-CSE-MsgGUID: Ry32zIZGRqyOIduJgGaEow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="227787217"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 07:29:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 07:29:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 07:29:15 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 07:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIMWZu6GA6ZToPusaye3XchJy8DwIb/QumGbCIkf2BIqGId2NY5bgFL9y6lIp/kzNUbRrFaiH3mCrBL15rzEl+Rp1bIHpFBIgWJ14B/0bGml4MrHpR1AyYbPEI+ubcDkxKl7OV5a438+Go2ZgG4+2PB5r38/zl1IU4UkUgm3zuxzlZq2Iogm/KIzaqPeHriz7cLagqYLZ6B41U3A+eXB8UvIaFQjiKFDaRNHi9s1xJp6pgXYsLdc42/XtzdXfv9JhX43zx9xiDRWT5Ju2MV8oqjvSF38Dwqf0RJJmw4oFhyorktKZ2FkKONZoN3Om+b6GRB3KdVzhQB1fWYEFWI1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3VAG8NtA/lk7TlfU2DixiP2R5SrtVUhrZpOklD4Bpc=;
 b=Gde3b1bZB0lFheO32Lbl6jsU59geYp5jUcW3s6qRlrz7I/u/P6pbcH8TpJXeBjsxjtpw/n3zdzoVqJmbj/pe+MfPfuiKGt+83v5UH2tHSst0Ha/rYvMSk6KFTE4VfehV9Macv+OHUvwrTwqDIRGKft1NQCPzAOa8MnaS/ga4HFCFEfkIm4yHAZVk+a75U1yz9GkVtlzhePjkGktJeP7hcTC89xbWd3vwSTwcxzfP7Zp8gATxx0eDF75QyMxgpDrkbBsPfshqVDgRgpeGURcVX5fatyLkclj7n7UccE5vpMt+/aQ+TS65myy4/jiJxjIrEe8zutLei+LpE+txGPnFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 14:29:08 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 14:29:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "Nowicki, Robert"
	<robert.nowicki@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Swierszcz,
 Igor" <Igor.Swierszcz@intel.com>
Subject: Re: [PATCH] x86/tdx, KVM: fix HKID leak when kexec is initiated with
 active TDs
Thread-Topic: [PATCH] x86/tdx, KVM: fix HKID leak when kexec is initiated with
 active TDs
Thread-Index: AQHc0mRhooIOtEMz0kqquT9e8pVJ3A==
Date: Wed, 22 Apr 2026 14:29:08 +0000
Message-ID: <6aa7f5e57ffa05cb068956c643d9e2be7630b285.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260422124536.53756-1-robert.nowicki@intel.com>
	 <aejJup_I4wM0Rb93@google.com>
In-Reply-To: <aejJup_I4wM0Rb93@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB6471:EE_
x-ms-office365-filtering-correlation-id: c3cb7c85-b183-4e00-35ab-08dea07b83b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: yLc/VcmylyTbGP5v2LctKcpoQi/uCnJlASBqoEAocdSTF9MsnOEgGAxJv/H5Rj+4MTry3q1kXViKn2pkNI+SBV+gcoKz0CcAJFhgDa7X83MRvhArovvvDg668THrKhlgF+mzN8bKbTsByyY7bh55V7O2VUXZ/csO77XXHxWMSbUgTHDhMPIMEXyRJHzHGHNNwzf/YWJ+fHqq5bMpjuXaYWDEJe40bfjsh8DxmjsKjiOeniRbV78MIU4DU/YbLgc9cjISJfM5vPnrsRJq+ls/Stv4GOJU7r1EveE2ajvDk2idRetIaHUUUGsnCcM4LRT5B5I0gfWPZzJ2jqHUeWgHRJ6F2ZB+48oV3jhmyvyzCRI/G8Fk8XBdZXWwdqOtDpC6tyqS1fpIcs0V9n7g0bLKwD+7Mx+ZTGwkbJwBbW9mAAGTD+8jJGaOMAhBEqvhjMiMn0x/vBRQPxyUPjIEGYBtCGFzxAqx3EotenyNia7NHAW5ilA9N3wHBv2Zc141N0Xk36xoTMwOOSb6zyigK8sjThl6vGbgfNxbCs7Rq+cDfPhWGlqbp9+6qJ+U7iKsDqfuY6VC3MyTCjb5x2MUr+uav9MH1SMQhk6Ss/eaBZpafBb7xZTsPSw7Q/FPVpoLdzJQyqJSbQDoLfA0nHDZSa7I5rakkbr8Hrv5PmcauDFKpNdHR4cTjDrvqeSjXruD//HNCk1t3iyvbMuiFkEb6Q7hsBMnf5VMOOVXXCOQfT2+F/AyTiT2CD/LGvsbL2Kjshmvb7N+jKWEOaBIyp8PrgjEwIEh8rPoAtLW+qq3OBVWLXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTR4UWJ1czRFa05LLyttV2M2d1hURWZMZEpZMTNnVFZPNVVEZmZKZXovaE5w?=
 =?utf-8?B?a3VOd3FTRXpKekduY2ZSOFVVL1ZNQ3AzbTBzMVlXUDFackdjOXVFK1RrcXl5?=
 =?utf-8?B?Tit0VHJMVkRBQmpMTGNJbkQyQzU0NHJkOHlFTXMxWVg4blE3OVJ0ckZIQzR2?=
 =?utf-8?B?RUxIKzJ3czNTY09Zc3Y4UncyWkE0MkJtc1grZzBXd2toaFJKZkQxMDYzTHE5?=
 =?utf-8?B?cVhoNS9abFRwS09SYVhvWHpRVFBraTRnZUcwSXgxanVGd09tYlVJQncwaWNw?=
 =?utf-8?B?RzVjeTVoSWlhaGFwNmhHcTc3WGlLaHVmTmk1UVVnZURHK0cvQjJrMDlCMStz?=
 =?utf-8?B?WjV2RHhLZEZad1I4NHEzRnVjL0ppTzZyUDJvSnJ2KzRVaTFma2tJSXhDcDVk?=
 =?utf-8?B?ODJ2Z2d0MVgxVEpBdGsxcUFWY0plNEZ2c3BEWmV1MTJFRUdoRHRFSzVJRkV5?=
 =?utf-8?B?YkV1bmk1UWh2Zi9SVTFQQzMzYTZQbEJoamVhM1BMMWFmSG9OUXlqVW9aYjFu?=
 =?utf-8?B?L0l2VVJqMFEyNktSckNPMHhMMWFqRDIyN0RPVE5KNXltREFLRlB5MjlsVEsx?=
 =?utf-8?B?czg0TEhOTEkvK1FUN1E0Uk9ON1NmaHhTQXVFQkJVSG5lem1hZWVjVHpsdDVM?=
 =?utf-8?B?Mng2UFhzY29kOXI2ODBtNTY3aXFDNktodVlhSDNsVUxPNHcxTXdaRC9IdnJs?=
 =?utf-8?B?dklqWEMxZko0bVRsVlRZUzZuSGtlNk9tRzVQcUhobjdPQjZlR3h6eVI4M2lE?=
 =?utf-8?B?R1BYNDJoRlpWd2NqTy9XSjdWNFliN3BFeFhheVFrdDJYSWNyaG4rK2dqSkg4?=
 =?utf-8?B?UnlxcHg5OWxlSy81WkQzbkRGOVNVbmtYMGNFVlRGcGZnSDhVUFFmZEQzNHhv?=
 =?utf-8?B?Qnc4L0ViejJYRVloOUFmb1ZHdGdkUTM2ejB6ZUQ3cTkvN3NsYUhjOVBCSWhU?=
 =?utf-8?B?MEFMMjNCODRRK2RVWlpicVRVL3FDbytNQVV0M0o4ODFEUGhvLzc5OUo5TGdz?=
 =?utf-8?B?UXJ2V3JlU1BjRmFYMDl3WEJ4Z0kyZ3BGTXFlU255UmlLV1B3eUo3U2tCTi81?=
 =?utf-8?B?dGFFd3BMUU1kL0RONDY3Wk5IZXM4d0ppeXFCWmZNdEx3Q2dmSFVZY0FTWjE5?=
 =?utf-8?B?ZXhiZUxlcXgwb1M4cENsNjgrQnNrRzlMSXRpS29OdGh2R2Z4K2Y2ejNFdkV6?=
 =?utf-8?B?UW15dFhVNktiOHJvNFNyOUJJN0ptWnVIeFc0SCswcUVHN2lZSDdkR3kvQXZD?=
 =?utf-8?B?ZUQvNEhhM2JVdW1iMFJsaWtsSUdNNHRSUC9lWWN4SFB0MFNWYzJLT0U1WGxH?=
 =?utf-8?B?NXpIR3QzTS9kdzVnUTRLc1h5MmJWa0pIeFJsYldMbjJGSEx1OEM3YlpMYlJX?=
 =?utf-8?B?M3JHQkZGcHhFYW9WUmZsbXhpWUI3Q1RoSGJGTkxNQXE5LzhIVFBZWFhpY29z?=
 =?utf-8?B?NklGUUZGTitQcVBHNXVRNHlody93N3dtUk8wa2duZzVXcVFDYlJHWlRiTXJN?=
 =?utf-8?B?RTRzd0NuRFNkYmk1aXdobFRjbnZ6MmQwMW90QStXTFNEbjhieU9MV2UyVHY5?=
 =?utf-8?B?dnhyVXRvTXgvRlhNRUhkdU9CU3dieFBKUEpXYmQ2OExEZ2JnN1RTMmFwTkZz?=
 =?utf-8?B?eDY2ZzJQckdaN1lPNEVHb2tFMTBWd0RRdFZyZTYwVGpkK2hqRm52QWtpb2ll?=
 =?utf-8?B?bEFzNHVPcndMNVBPbllNbm81eUFLOEg2Q0c5TllIZ0ZjVXNrbzhRSmRITVN3?=
 =?utf-8?B?KzdiekpIUHRSeFh6UzNCanZRdkhKNVpCc0l3SFd2Vis4TTVZeWl2a3ZIc1Vu?=
 =?utf-8?B?NEhtMWVNVHdxcEcvR1o3dTBxSHpnR040eThLR0FncWhqaGZVdkpVaGVOV2RC?=
 =?utf-8?B?K3lyZk1zUDZJYU9aLzVWNWMrQnN5Y2tUZ2ZIMjFHZ2RkZmNVeUovbHlFKzZF?=
 =?utf-8?B?QjZzTjU2R05ObldhV2VFa1d6WkVBMmNiWVBGMXFKcmNLOXkreWtITDE1ekM3?=
 =?utf-8?B?N216NkROaDNVS1VMWnZnVjBzbldhRUZ6bk05aVN2QUJOdE95OHFiZHBMOTZQ?=
 =?utf-8?B?Q1lFekRXdkRDb3NUMGI4ZU1TTGVGRVJPa2dZSi80YlBOUzhlZUtzU21VNkF2?=
 =?utf-8?B?a0lpa0RiTk9OS3J1blRsbEVMM255R3NzbVRDWmdmTk5WTTRWdTdFYWd6dlQ2?=
 =?utf-8?B?TS9CeGJIR2c0c0xpTkhIT0xKeityeEJ3dG50S0tSUnplSXF4eUZPZkh2NEhv?=
 =?utf-8?B?NTdCK3A0djdWTVBJNnY0VVJQeHlCK1BqS0RObXc4NWQ3YVU1elZTak1iaFBR?=
 =?utf-8?B?dlR5Y1J2bTM2THpyOGdFTGlZVlpySW1YZE9DRDJ2QjN5T2p5ZmhNWFVIQlY2?=
 =?utf-8?Q?dAjsMeO2+In+w+FQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EB3FAB6DEB8494DAA367BCE433D0EAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J2lUkRv0MFFUZbk97XM+MhUrUoxY/VpGhydxkIVunrM1fB+TuicZhe+B1aL7XVh5uaQmdYTIbUtFL9yH3Vd41vboqAgbqhp2DMslZFBuTZu8Hs1ww8MyckIWNe3c+uxC+kfl5ftJ9ZCEnis4CLiorWgkuQ00FQK3tbPTj31eRAW2dj6SL+HmF7KUcl6hXRfUAxqKm6u7sjFH9X98nWkHXuqHeSNWOk/mwax9qW9ers6hSL2FELHSEvN7OO+x4iIkZYCpThqL5cUukXL/fPyIRraZOEtxfE0bJ8iloEiuN5m7+dYJNjgEqhbMbEG0Y+0j45N0MnCqMCHJC6z1m3K9Lg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cb7c85-b183-4e00-35ab-08dea07b83b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 14:29:08.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDDF1fH0UkVTW4cAz5kRHvSoDbB90By7IXwIQlhaJ6+cKFOxEijsu0YCEF0kVfWp4OxX/jG9tkUmtYK/1a/LUtFXw6YWGuyCODh1Uw+Tb2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTIyIGF0IDA2OjE0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIEFwciAyMiwgMjAyNiwgUm9iZXJ0IE5vd2lja2kgd3JvdGU6DQo+ID4g
V2hlbiBrZXhlYyBpcyBpbml0aWF0ZWQgd2hpbGUgVERzIGFyZSBydW5uaW5nLCB2Q1BVIHRocmVh
ZHMgY2FuIGJlDQo+ID4gbWlkLVRESC5WUC5FTlRFUiBvbiBvdGhlciBDUFVzIHdoZW4gdGR4X3No
dXRkb3duKCkgZmlyZXMuIFRoZSBURFgNCj4gPiBtb2R1bGUgcmVqZWN0cyBUREguTU5HLlZQRkxV
U0hET05FIGZvciBhIFZQIGluIFJVTk5JTkcgc3RhdGUsIGxlYXZpbmcNCj4gPiB0aGUgSEtJRCBp
biBhIGxlYWtlZCBzdGF0ZToNCj4gPiANCj4gPiDCoMKgIGt2bV9pbnRlbDogdGRoX21uZ192cGZs
dXNoZG9uZSgpIGZhaWxlZC4gSEtJRCAzMyBpcyBsZWFrZWQuDQo+ID4gDQo+ID4gRml4IHRoaXMg
YnkgaW50cm9kdWNpbmcgYSBxdWllc2NpbmcgZmxhZyBzZXQgYXQgdGhlIHN0YXJ0IG9mDQo+ID4g
dGR4X3NodXRkb3duKCkuIEtWTSdzIHRkeF92Y3B1X3J1bigpIGNoZWNrcyB0aGUgZmxhZyBhbmQg
cmV0dXJucw0KPiA+IEVYSVRfRkFTVFBBVEhfTk9ORSBiZWZvcmUgYXR0ZW1wdGluZyBUREguVlAu
RU5URVIuIEFmdGVyIHNldHRpbmcgdGhlDQo+ID4gZmxhZywgdGR4X3NodXRkb3duKCkgY2FsbHMg
b25fZWFjaF9jcHUodGR4X3NlYW1fc3luYykgd2l0aCB3YWl0PTEgdG8NCj4gPiBlbnN1cmUgYW55
IENQVSBjdXJyZW50bHkgaW5zaWRlIFRESC5WUC5FTlRFUiBoYXMgZXhpdGVkIFNFQU0gYmVmb3Jl
DQo+ID4gdGR4X3N5c19kaXNhYmxlKCkgaXMgY2FsbGVkLg0KPiA+IA0KPiA+IEZpeGVzOiA1ODE3
MWFlMjJlMTEgKCJ4ODYvdGR4OiBEaXNhYmxlIHRoZSBURFggbW9kdWxlIGR1cmluZyBrZXhlYyBh
bmQNCj4gPiBrZHVtcCIpDQo+IA0KPiBQbGVhc2UgZG9uJ3QgcG9zdCBzZWVtaW5nbHkgc3RhbmRh
bG9uZSBwYXRjaGVzIGZvciBjb2RlIHRoYXQgaGFzbid0IHlldCBiZWVuDQo+IG1lcmdlZCwgaXQn
cyBxdWl0ZSBjb25mdXNpbmcuDQoNCisxLiBSb2JlcnQsIHdlIHRyeSB0byBjb29yZGluYXRlIHB1
YmxpYyBMaW51eCBURFggd29yayBpbnRlcm5hbGx5IGJlZm9yZSBwb3N0aW5nDQpiZWNhdXNlIHRo
ZXJlIGlzIHNvIG11Y2ggb2YgaXQsIGl0IGdldHMgY29uZnVzaW5nIHRvIGNvbW11bml0eS9tYWlu
dGFpbmVycy4NClBsZWFzZSBjaGVjayBpbiB3aXRoIHRoZSBMaW51eCBURFggZGV2ZWxvcGVycyBi
ZWZvcmUgcG9zaW5nIFREWCBwYXRjaGVzIHNvIHdlDQpjYW4gaGF2ZSBhIGNvaGVzaXZlIGVmZm9y
dC4NCg0KPiANCj4gPiDCoCB1NjQgdGRoX3ZwX2VudGVyKHN0cnVjdCB0ZHhfdnAgKnZwLCBzdHJ1
Y3QgdGR4X21vZHVsZV9hcmdzICphcmdzKTsNCj4gPiDCoCB1NjQgdGRoX21uZ19hZGRjeChzdHJ1
Y3QgdGR4X3RkICp0ZCwgc3RydWN0IHBhZ2UgKnRkY3NfcGFnZSk7DQo+ID4gQEAgLTIwNiw2ICsy
MDcsNyBAQCBzdGF0aWMgaW5saW5lIHUzMiB0ZHhfZ2V0X25yX2d1ZXN0X2tleWlkcyh2b2lkKSB7
IHJldHVybg0KPiA+IDA7IH0NCj4gPiDCoCBzdGF0aWMgaW5saW5lIGNvbnN0IGNoYXIgKnRkeF9k
dW1wX21jZV9pbmZvKHN0cnVjdCBtY2UgKm0pIHsgcmV0dXJuIE5VTEw7DQo+ID4gfQ0KPiA+IMKg
IHN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IHRkeF9zeXNfaW5mbyAqdGR4X2dldF9zeXNpbmZv
KHZvaWQpIHsgcmV0dXJuDQo+ID4gTlVMTDsgfQ0KPiA+IMKgIHN0YXRpYyBpbmxpbmUgdm9pZCB0
ZHhfc3lzX2Rpc2FibGUodm9pZCkgeyB9DQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCB0ZHhfa2V4
ZWNfcXVpZXNjaW5nKHZvaWQpIHsgcmV0dXJuIGZhbHNlOyB9DQo+ID4gwqAgI2VuZGlmCS8qIENP
TkZJR19JTlRFTF9URFhfSE9TVCAqLw0KPiA+IMKgIA0KPiA+IMKgICNlbmRpZiAvKiAhX19BU1NF
TUJMRVJfXyAqLw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3RkeC5jIGIvYXJj
aC94ODYva3ZtL3ZteC90ZHguYw0KPiA+IGluZGV4IDUwYTVjZmRiZDMzZS4uMmQ2NThkYjc3MDBk
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2t2bS92bXgvdGR4LmMNCj4gPiArKysgYi9hcmNo
L3g4Ni9rdm0vdm14L3RkeC5jDQo+ID4gQEAgLTEwNTMsNiArMTA1Myw5IEBAIGZhc3RwYXRoX3Qg
dGR4X3ZjcHVfcnVuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTY0DQo+ID4gcnVuX2ZsYWdzKQ0K
PiA+IMKgwqAJc3RydWN0IHZjcHVfdGR4ICp0ZHggPSB0b190ZHgodmNwdSk7DQo+ID4gwqDCoAlz
dHJ1Y3QgdmNwdV92dCAqdnQgPSB0b192dCh2Y3B1KTsNCj4gPiDCoCANCj4gPiArCWlmICh1bmxp
a2VseSh0ZHhfa2V4ZWNfcXVpZXNjaW5nKCkpKQ0KDQpUaGVyZSBpcyBlc3NlbnRpYWxseSBhbiBl
eGlzdGluZyBrZXhlYyByYWNlLCB3aGVyZSB2bXhvZmYgaGFwcGVucyB3aGVuIFNFQU1DQUxMcw0K
Y291bGQgc3RpbGwgaGFwcGVuLiBJdCBnb2VzIGJhY2sgdG8gdGhlIGZpcnN0IFREWCBrZXhlYyBz
dXBwb3J0IChpLmUuIG5vdA0KaW50cm9kdWNlZCBieSB2bXhvbiByZWZhY3RvcikuIFZNWCBLVk0g
aGFzIHNvbWUgc3B1cmlvdXMgbG9naWMgdG8gaGFuZGxlDQpzb21ldGhpbmcgc2ltaWxhciBmb3Ig
bm9ybWFsIFZNcywgYnV0IFREWCBkb2Vzbid0LiANCg0KSSBkb24ndCBzZWUgd2h5IHRoaXMgVERI
Lk1ORy5WUEZMVVNIRE9ORSBjYXNlIGlzIHNwZWNpYWwuIElmIHRoZSBURFggbW9kdWxlIGlzDQpz
aHV0ZG93biBhbmQgdGhlIG9sZCBrZXJuZWwgaXMgZ29pbmcgYXdheSwgaG93IGlzIGFueXRoaW5n
IGxlYWtlZCBvdGhlciB0aGFuIHRoZQ0Kbm9ybWFsIHR5cGUgb2YgbGVha2FnZSB0aGF0IGhhcHBl
bnMgZHVyaW5nIGtleGVjPyBTbyBJIHRoaW5rIG1heWJlIHRoaXMgaXMganVzdA0KdGhlIGtub3du
IHZteG9mZiBzZWFtY2FsbCByYWNlLCB3aXRoIHRoZSBzcGVjaWZpYyBjYXNlIG9ic2VydmVkIGdl
bmVyYXRpbmcgYQ0KbWVzc2FnZSBhYm91dCBsZWFraW5nLg0KDQpBbHNvLCBub3Qgc3VyZSBob3cg
aGFuZGxpbmcgVlAuRU5URVIgd291bGQgcHJldmVudCB0aGUgVlBGTFVTSERPTkUgY2FsbCBmcm9t
DQptZWV0aW5nIGFuIGVycm9yIGFuZCBlbWl0dGluZyB0aGUgc2FtZSBtZXNzYWdlLiBJZiB0aGUg
VERYIG1vZHVsZSBpcyBzaHV0ZG93bi4uLg0KDQo+IA0KPiBSZXF1aXJpbmcgS1ZNIHRvIGNoZWNr
IGEgZ2xvYmFsIG9uIGV2ZXJ5IGVudHJ5IGlzIHByZXR0eSB1Z2x5LCBlc3BlY2lhbGx5DQo+IHNp
bmNlIHRoaXMgaXMgZm9yIGEgdmVyeSByYXJlIHNjZW5hcmlvIChpbiB0ZXJtcyBvZiBudW1iZXIg
b2YgZW50cmllcykuwqAgQW5kDQo+IGZvcmNpbmcgS1ZNIHRvIGRvIGEgQ0FMTCtSRVQgdG8gY2hl
Y2sgYW4gYWxtb3N0LW5ldmVyLXNldCBmbGFnIGlzIGVzcGVjaWFsbHkNCj4gdWdseS4NCj4gDQo+
IFdoeSBub3QgaGFuZGxlIHRoaXMgZW50aXJlbHkgaW4gdGR4X3NodXRkb3duX2NwdSgpP8KgIEUu
Zy4gaGF2ZSB0aGUgbGFzdCBDUFUNCj4gdGhyb3VnaCBkaXNhYmxlIFREWCwgYW5kIGhsZCBhbGwg
dGhlIENQVXMgaG9zdGFnZSB1bnRpbCB0aGF0J3MgZG9uZS7CoCBJdCdzIG5vdA0KPiB0aGUgcHJl
dHRpZXN0IHRoaW5nIGluIHRoZSB3b3JsZCwgYnV0IGl0J3MgZW50aXJlbHkgc2VsZi1jb250YWlu
ZWQuDQo+IA0KPiBzdGF0aWMgdm9pZCB0ZHhfc2h1dGRvd25fY3B1KHZvaWQgKl9fbnJfY3B1c19y
ZW1haW5pbmcpDQo+IHsNCj4gCWF0b21pY190ICpucl9jcHVzX3JlbWFpbmluZyA9IF9fbnJfY3B1
c19yZW1haW5pbmc7DQo+IA0KPiAJaWYgKCFhdG9taWNfYWRkX3VubGVzcyhucl9jcHVzX3JlbWFp
bmluZywgLTEsIDEpKSB7DQo+IAkJdGR4X3N5c19kaXNhYmxlKCk7DQo+IAkJYXRvbWljX3NldChu
cl9jcHVzX3JlbWFpbmluZywgMCk7DQo+IAl9DQo+IA0KPiAJeDg2X3ZpcnRfcHV0X3JlZihYODZf
RkVBVFVSRV9WTVgpOw0KPiANCj4gCXdoaWxlICghYXRvbWljX3JlYWQobnJfY3B1c19yZW1haW5p
bmcpKQ0KPiAJCWNwdV9yZWxheCgpOw0KPiB9DQo+IA0KPiBzdGF0aWMgdm9pZCB0ZHhfc2h1dGRv
d24odm9pZCAqaWduKQ0KPiB7DQo+IAlhdG9taWNfdCBucl9jcHVzX3JlbWFpbmluZyA9IEFUT01J
Q19JTklUKG51bV9vbmxpbmVfY3B1cygpKTsNCj4gDQo+IAlvbl9lYWNoX2NwdSh0ZHhfc2h1dGRv
d25fY3B1LCAmbnJfY3B1c19yZW1haW5pbmcsIDEpOw0KPiB9DQoNCkFmdGVyIHZteG9mZiBoYXBw
ZW5zLCB0aGUgU0VBTUNBTExzIHdpbGwganVzdCBtZWV0IG90aGVyIGVycm9ycy4gVGhlIHdyYXBw
ZXJzDQp3aWxsIG1vcnBoIHRoZSB2bXhvZmYgY29uZGl0aW9uIGludG8gYSBTVyBlcnJvciB0aGF0
IG11Y2ggb2YgdGhlIFREWCBjb2RlIGNhbid0DQpoYW5kbGUgZWl0aGVyLiBTbyBpdCBkb2Vzbid0
IGhlbHAgdGhlIHByb2JsZW0gSSdtIGFmcmFpZC4NCg0KSXQgd291bGQgYmUgbXkgcHJlZmVyZW5j
ZSB0byBmaXggdGhlIGV4aXN0aW5nIGlzc3VlIHNlcGFyYXRlbHkgdGhhbiB0aGlzIHNlcmllcy4N
ClRoaXMgc2VyaWVzIG1ha2VzIGtleGVjIHdheSBtb3JlIGZ1bmN0aW9uYWwgZm9yIFREWCwgYW5k
IHRoZSB3b3JzdCBjYXNlIEFGQUlDVA0KaXMgYSBzcGxhdCBpbiBhbiBvdGhlcndpc2Ugc3VjY2Vz
c2Z1bCBrZXhlYy4gU28gYSBub24tY3JpdGljYWwgYW5kIGV4aXN0aW5nDQpwcm9ibGVtLg0KDQpL
YWkgYW5kIEkgd2VyZSBwcmV2aW91c2x5IGtpY2tpbmcgYXJvdW5kIHNvbWUgaWRlYXMgYWJvdXQg
dGhlIGdlbmVyYWwgY2FzZQ0KcHJvYmxlbS4gSXQgc29tZWhvdyBtaXNzZWQgb3VyIGNsZWFudXAg
bGlzdCwgYnV0IEkganVzdCBhZGRlZCBpdC4NCg==
