Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D7238C0A;
	Mon, 15 Jun 2026 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491396; cv=fail; b=obS6kfsEOTVsZ2W8FT09M5C0al9cGQB7lcw5V++jJGVDCf7fkuBC+djpQ3a29dLcn9FwUf/z9lhwGt83FRXxDtER/I7aR8n6vDZgpBDXCx7BS14bCD203FbSG/RUy86321RojwYl0Md9WanZUqBigUbf4IyvOPij8GNPKf2w2U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491396; c=relaxed/simple;
	bh=THQaysLTSH4MRan8Zj9nQ5VhRkYCsmf5MKS8DW+iegc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VyKU+WnePHe6BeL0cNPAMbVpeImw0q8VBWlnzasPacF/HG6yObDoCFAiPTH5EuQJPYHXoz1ZspjDLGe/4yGEIkvDut5h+6mkhN6JARjZHoyTB7+/qKBgQbajMK856R7etIh3Cewn6plolwTGKeUp5KAf5cD432SPuARRlGvAnBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ba7ekf+7; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ba7ekf+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781491394; x=1813027394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=THQaysLTSH4MRan8Zj9nQ5VhRkYCsmf5MKS8DW+iegc=;
  b=ba7ekf+7+Dr+QNjPtYjmm9A6hibAZWc0IYW6uJeMOqk8c52Qjw0zyTU8
   x0YBT2TUz4AKfyYABMose/lweEYSDzH3YO9XqXyQh5HCRbCgRPItXTKxZ
   aM6hSAuGwN2UBttOkwVGMj91R8yVU1JV2vrZC6mP7lxUk5GIohzZxWrgH
   6ix6iN1P3mElTOHxou0B6EbEMVwAUZPbXGBpNSTLaIGDGldS6C15D5l2f
   qcpHH/v6KZ7lsRmgvk5ZlDkFjRACuC4Bu/SvEe1IIfxoik2+VBm3WNQyZ
   oLEl41Ijva8/7LYItEBVlcRKL/vF258XFdDeupWNIbCfT2gOhJHJKZ+o2
   A==;
X-CSE-ConnectionGUID: IsH1h5FASF2pppYej/s6XA==
X-CSE-MsgGUID: QywQq86lSwq2czbSPw3QzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="104896600"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="104896600"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:43:14 -0700
X-CSE-ConnectionGUID: TNrx7wEjQIGke/9bnUPCDA==
X-CSE-MsgGUID: 0jx+icuXRECizM/A82cVzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="271022950"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:43:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:43:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 19:43:12 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.37)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkDVGd0pHPA80E+qe85fNnwchbbESGrj/xaBLLd/2JFL1RqFJfhyiOU44T+/Z+Fd9M0Kq9UH+6/GwlfIs6brSmkZdjClp/VFZObr3MUkLqc0qS/mqlBvbcZoRJfL8evec3WeGOZKvvPeMmtzuAEOX7Po+Xi2lZ73EarlaJe0r6UCR1vDdOitZ5yPGgKY+gvygrwCMcjL8jjpSU6hNys066oGNokHEcm4AJdCbjXg9czVazMII0bPupAgDwGsExjlf1Fg74sZLm1he3IAbSBNYHHqS1BFCDwqZhio+ZJ5ta679wkT9ww4KmVoYxriR275PgubzM2FHSe8bekJh6YhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THQaysLTSH4MRan8Zj9nQ5VhRkYCsmf5MKS8DW+iegc=;
 b=E/v+R5yPcsFY3AEMSmaED7IkY8nuX6/xcJnd8vKasHqumpWJIZu3nMnLGtjnsBhgrdzruH5PpwXWrusiea6Dna7gHT1hDV3Bc4O3Uy5B5T36sZuFNPRs56uNotsJltOhlv9J6yzh8N0/lsYFn4YfbHvPLr7+2pC2uQ7mUyi4SZkjfAFOJ0+osvwBhgswwR4zXoKxPp+DwrAft8yE/xfHc5AjuRTWojtcD+wKaDDfBX2cfcDAGtg7iIC2uvwJWWY6Y8ENkTXoFrGNCZfWYZEEw9eW9WBNmQRm8jxpsJNo3Pi58A/ZtiTbRTh5m46CY2Glr/pA6SX6T9wBW71gOuHEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH3PPF1618AF7BB.namprd11.prod.outlook.com (2603:10b6:518:1::d0a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 02:43:05 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 02:43:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH v4 02/30] KVM: x86: Move get_segment_base() to regs.h, as
 kvm_get_segment_base()
Thread-Topic: [PATCH v4 02/30] KVM: x86: Move get_segment_base() to regs.h, as
 kvm_get_segment_base()
Thread-Index: AQHc+sgdL9iXcTKuj0SUHsPBO/daH7Y+684A
Date: Mon, 15 Jun 2026 02:43:05 +0000
Message-ID: <a40430b8e35ce8a7950a394131aca1c129fe2e76.camel@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
	 <20260613000329.732085-3-seanjc@google.com>
In-Reply-To: <20260613000329.732085-3-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH3PPF1618AF7BB:EE_
x-ms-office365-filtering-correlation-id: b15ab33f-d1a4-4b28-9c9a-08deca87d383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: 7yPUyoQ4JO1lAW4uv9B+vG48ZqFmtcftcE8iEWjqA6mKNiyVypPU4XpowyWxMrytW5b1yptxGFbEDbyQGAUTIO8JE9RuS61hf90HIH2a8kW0iCMc/IoTu9BAcj3PgRTPPNdVSZ2raVo85Ae3nv/Bfy0/R8dt5atjYLUlQUIIBo5PSPwbYrxPthnanTS5TkMXvhk8zTvK+3+ok7AocfRbOT44TZE0COamPDbpRpq8eUaGZoDfyWYYRhUc6FgwOyJMwowUWeGIeX1gGqwvXLwmWXkllvRsJCZRqeh53VK+dLH7Hi5/gOiFFyK111C8AjwLH0gpu/k1S9O9Z2vRq1lIYc36pJq5g8xh2JrOwhWBuRZcAzL2SEB78krsAPbg3yI8tFndi+IVCitk4wqpHcPVHGqHlHBc7fgVsNx/KZ7Vb36sXRiVbZlvp5VIKaW4isWN/gcWsabxbWIhPnANe2o31WaOeWer61PopJAOI/42FyCYAXsm44R7u1pNkAEU+uYhtye9dLZ9iFeD6lFsJv0oWCj8kH9kilIReT6uAoNHjDyEXeRO3CLummba9qHOSy34oA33GWSVqXi9RJ7V61BL0k4XJMgNalGe+q1e/lU6ZF/zSOe+SD01l+wLXRR3I997uLvW4q7nQEeunnwzi0LI6FRjSAsT3JbZmuoMjYz+FYQ+twgpQ+guicDvQFarGHAOxtPPXlHMrAYBjvfkBX3dz5f2ycjm/I3DuQ522C6rjBnp6JDcFWHR6wq0qhH+6TYd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjQydyt6S2FBYXMzZVlUYWJnS0YvcnBFejNhUmVNQkVvN3dtOHZWalVlWCt5?=
 =?utf-8?B?dlRLNGNVN3pjVmdQTzY5Qzd2VWdmVkVGKzJabUU0NEVjM1BtK0dXTVJWcVJs?=
 =?utf-8?B?cTNLZzJ3S25nTkxIaGhqRS9YdnhwNWpvTlAySDNPcEFaQWJOanFxVG1GZGdT?=
 =?utf-8?B?NVh5YzR1UG85UU9UZWgxTm1hYXlJN2tybVJjMFBJRWE4OWxqSVRDK3B5T2pS?=
 =?utf-8?B?dTY0NVlXWjgxazU4UzVqaXhraGNQdnRlTXJFQXppaFJReVlMeDV0Y1lrN3F6?=
 =?utf-8?B?dTQvNUEyTmF0QVRXYys4NGFWOVROUVNOaUo3SWxpQzU1NCtXQ3lraDF6Wk94?=
 =?utf-8?B?UmQ5a2dMbEFObUZXcUI5eXhDS3F2NkFIVmpWeElIMnZYSm1MQXJ1S3RZTngx?=
 =?utf-8?B?emw4YkpvVm5UTkdQTlVzYlBUVmNsenZvdThwTVdjMHVYWGhUZUtGQ1ViK21k?=
 =?utf-8?B?NkNjUUxhQzdvbWpHV0pseEpaRzhzTkpLS3ZFTnNrc051dWFjM1dEdzU5Zkds?=
 =?utf-8?B?RERmOHplSHdCVEdLVDlyTUhNQ29sWVJuOXM5RHZma2k4S2FzMVdoL3A4b2d4?=
 =?utf-8?B?WUtpY0xVRUJnZFRLRStYaHBsbWlYbFRPa2NIS09CWC81MklDOWh3aVFNWHJS?=
 =?utf-8?B?OEFJeDJWUDlJek9aL3ZDYWhUcVNicFZHWm1FSE44d3UyVzJOVWhSM2wyRkxw?=
 =?utf-8?B?cU5SUVQ2NHBsazluUHdHMUExTUswOUU3dGRNV1JuVm9NZFUyVXN1c0RqUHdl?=
 =?utf-8?B?M1JLYlVnZmsreHVSTk5zbEtndURDN2xlMXBpajZBWXFqTSt3UVMrMnJTMnpS?=
 =?utf-8?B?TWYyZFpUQXRKcitWQzBFTGpIcWh5NXo3b1lFMlplVEw1KzBYbGpBN3FaMXQ5?=
 =?utf-8?B?RkhQZlBRanErWE1oRSsrT2VxSGNxMkh3QVhBdEJ3K3p1ZUlsYWlDWHNZLzlR?=
 =?utf-8?B?WmlPNmttYVc3YnRnZ0UwZVB2bFU2Tlo4Um9vdnAyWlQ2OW15NGRobUJ3SzRB?=
 =?utf-8?B?bDcycGs3WnpHdmhvNXo2Umo3bnNZYk1VaFRwMjBTSHhJZUdJaVBrbVZiL0RG?=
 =?utf-8?B?Uk81QUdMaFJzS3RKVFdEQXJsazJvWW5YczdpN2J6dTQ0aC9QUmZ1Zmx3UFhs?=
 =?utf-8?B?Q0tBcjl5VlByQ0krNUZPQmV6d3FIU2dTamdVNkhMMUphZGJ0OHEwRmI1ZmIw?=
 =?utf-8?B?Tkp6WGJuUmsrOUlWS2dLL2JQU2ZoeEVOQWR5UU4yT0hZaEhlamtBNGlGc01C?=
 =?utf-8?B?VHI1dmVNQWpGTlhRMEJydUpoMnRPWVd0UDdLajhHNWluemhFWUdZbnIrMzFP?=
 =?utf-8?B?bFVYZFE3blNabGZtRXBWSG9OWHdrUFMwTnlNT0xyVjhOTDVRT3hvVjc1Tm5W?=
 =?utf-8?B?ajZxSEZJSUEvZHVUcm0wa2Ntd3UwN1gxdHlJaEJiSVBQVWpMTWh3UVhPQUxj?=
 =?utf-8?B?enlPMjZqMmlZQUg4OE50OEZiWHk3R2pXV3NWWHJ6SDQrM3pCSnUxNE8zMjBs?=
 =?utf-8?B?eVN6Q014eVdFQ2FxSi9SZWhZMFQ3NmxkN0syOTZPYkRkNG5CcjN3WVVVRDV2?=
 =?utf-8?B?bG0rRk5ZdEUyand4dWxCRjhhYWQ4dDA2dHVvOEVhZy8zUGtWV3RQUVlNL3VX?=
 =?utf-8?B?VklZZkI3N1g5OWZ2dkg2QkRNSWZLdWp0TjY1S1lkUzQ4dFdDcElXY1M3L0JC?=
 =?utf-8?B?VVk1dXhSbGM4QkdHSGlrK0VqNmNCVjdnR3dMdEN6eDJKNWNWajN6N1hteGZI?=
 =?utf-8?B?QkVUZVJGVGJ6YmVRWENqWmF5aEliNVRBZWQ3WC9vY2dTTWxIYjk0b1VTOC85?=
 =?utf-8?B?SjhLQkJGVFltcmRmYWpVb3JhWWsra0hxd29hclNmc1E5Snh5dXdKWXVoT3kx?=
 =?utf-8?B?cFQ5VFY5eG0rK2JRS2ZUVTFzWWc1UmlOYUJLMXNFazVPMGtMeHVKNWxYVUhZ?=
 =?utf-8?B?dmdUbE5kNUhiaWpjTjAzYVQ0TEl5SHdhYlhQZWFZdDNZWFBud0l1dnVGbU1L?=
 =?utf-8?B?QnRjWDNrblVob1dsQmdIcldLM3FNSmdHUm5XbktkUEZKSkNYbUI5YzdrUFpP?=
 =?utf-8?B?TmNxSDlFc2dpbjE5eHBmYjRsdnVlaEFWZXl5SzFRdGhBNDUzcTY5S1NDcGNq?=
 =?utf-8?B?WWdZTHpHdDJIWTZRK0NkYjNDaHlTVGZBU1IxN0RxYk16cDhtbnpGMGhNUEg0?=
 =?utf-8?B?dVRZdzlieFU2VkkvR1BRckVIVFQ2NldvcGM0OU1mcnBRVVp4QVJRL2JIR1Rq?=
 =?utf-8?B?cUEwRk5tNVg1NmNucm9Ga3ZzS0FMbFZxVHhpR2VTeG9zQk41cGtnR20rOVFL?=
 =?utf-8?B?Z0N5QngyTC92MWZSRWpFZ1VTcU5HMTN0dXp0YWFFZGFnOGlRVlhsQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88F68F680CB69942A37CA8BA7A30453E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U2im+GgNGfyXnCUF9uVh3EMTqpWIzn9eN7IrdQ+6i9oM4yfJxhDVMoymuC6CKdJoCdYX40KgzoATwxv2CA5xXBQ52LwVcDZOe9QIkku7b8AAim3A7NjrgXNYg9TzVpFAdbUyFS5ISMrKmccvyaPWKb8i37Pc8PfEiPGK9+OZvam7ifYGP58NQxOO/MnwmWtUeWfBjXBxydNfrS7Xf+bAygByWb4FT/EpIEvKbjiPMf2mENj1xH5fnT1yfeciCNbvdM3N93HMF0RNDFXLnGb+bYdE9TlbO5FVJ1GHt1eH4z5XWKpqAVT6yIvdJGACHGjF54YyqVD23ig9nWp1hfT9SA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15ab33f-d1a4-4b28-9c9a-08deca87d383
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 02:43:05.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ueYQ1lS+GGoLzq7NbkobCXMfvhySq6L6WGjNwBKQQrYtFyXko03Ksv90l1JjBsKGdS4WxqVXpxCUmoEE45fJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1618AF7BB
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTEyIGF0IDE3OjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIGdldF9zZWdtZW50X2Jhc2UoKSB0byByZWdzLmgsIGFzIGt2bV9nZXRfc2Vn
bWVudF9iYXNlKCksIHNvIHRoYXQgdGhlDQo+IGJ1bGsgb2YgdGhlIHJlZ2lzdGVyIGNvZGUgY2Fu
IGJlIG1vdmVkIGZyb20geDg2LmMgdG8gYSBuZXcgcmVncy5jLCB3aXRob3V0DQo+IHNpbXVsdGFu
ZW91c2x5IG5lZWRpbmcgdG8gcmVuYW1lICJwdWJsaWMiIGhlbHBlcnMgdG8gZXhwbGljaXRseSBz
Y29wZSB0aGVtDQo+IHRvIEtWTS4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVk
Lg0KPiANCj4gQ2M6IFlvc3J5IEFobWVkIDx5b3NyeUBrZXJuZWwub3JnPg0KPiBTaWduZWQtb2Zm
LWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0KTml0IG9mIG5pdDogbWF5YmUg
ZXhwbGljaXRseSBzYXkgZW11bGF0b3JfZ2V0X2NhY2hlZF9zZWdtZW50X2Jhc2UoKSBpbiB4ODYu
Yw0Kc3RpbGwgY2FsbHMga3ZtX2dldF9zZWdtZW50X2Jhc2UoKSBhZnRlciBjb2RlIG1vdmVtZW50
LCBzbyB0aGUgY2hhbmdlIGhlcmUgaXMNCm1vcmUgb2J2aW91cy4NCg==
