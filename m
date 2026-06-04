Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758642EEC7;
	Thu,  4 Jun 2026 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574602; cv=fail; b=Zab8j8zrN1CwazB2aGqZkxdv1umZ9JllTcSV73VAhecIQdBmQ8NrS05A7rRFruht0wliQEuUn24oLitnkeQucZoQHi2H2DF1c10W/i910r4N6V9gzN7TIEuBCiquM7YXJD9PK8/VwyTtgRbhSXvuf6lkLyRaigqjyP7VZuu3TfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574602; c=relaxed/simple;
	bh=fzucIiKjD8CZU2OarQRq+aAYv9hTvT4gHCvGTZNu5uo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p27kU5OSogGPMY6f2TB4DBsZ5mn7SgceZSor2Li5cgrOW+vGVAtj8snUe/70eKMZMkuQZL6Wqd54/gBGPrea+BcbuMUOH8tV/4/y7WXoXLiRFAFIdIN2aulxx/dm9IsPKB19j7w5f4SIxkeITCZP4SMeOfjPu623sb2c5fkexMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaFK4KUY; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaFK4KUY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780574596; x=1812110596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fzucIiKjD8CZU2OarQRq+aAYv9hTvT4gHCvGTZNu5uo=;
  b=MaFK4KUYAm1XH5dmUx35qrbzUqCPjzZnlgmVF8NQ6biif4RfWzINBsRG
   +CYBfk5JVZWw82BdorPBj6RVdbQItO+ZhwxSD1nHigJCIWydlGKsdkpkw
   xB1TJWj4InhdauQz/QSNuyuBLMQ7dZWGP+VaXkI53hglqM243TuLH0JMy
   gtNGq3ZGCV4ZNZKUx9MRU6VgDe1jhfuxjJC2Tt6fsUrXS7/YfvWJoxL8Q
   5YY2MGhG0mNsxFaMULO4dWC/wNL/3C7s4aG3+cIx37VDJ+KerA1+19svN
   ewbfT/qgnyhMpLXF1ftxrnlJ2ZA3jxyb8KXJaPtLwd5s97Rs1gewT5Mar
   Q==;
X-CSE-ConnectionGUID: 0LLCW+azRq6seJPrwSnMbg==
X-CSE-MsgGUID: hTcvYf1nQOmPt+YZ4BvDFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85253251"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="85253251"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 05:03:15 -0700
X-CSE-ConnectionGUID: MoZb0hGIS06Itwn+nr46iQ==
X-CSE-MsgGUID: 1otWu5ynTMKXALAVLAEqmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="268449094"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 05:03:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 05:03:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 05:03:11 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 05:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGjF5kv+3ss0jAGYjQNI2BnBSZmXn3VtKh1GS//F5g1dqIrWmUI4ltZqryr+P0ALCPGWhJ5aRGw7WEtlWiNyuU9bBSgFsIDXciLLbU2kkqVUpe7Obik+G4Sic6vm3AqGQ60Bp5Mkv7x0vmd7o7+vSIJ7FdVruk4a4XYKTwXEZgBySfVpm6scuM743CQR5c/6o4JFjwjfUDCOQPkC9biUwj2Le5Tjjo5+TkdZ4kOGrcXkkZD3OE5Xvj8fIMZ+VmIsbG+TeQPqMMsv3gbtykNSYcE3YFhzob+Bq47DEj8jMue82/MD5j5u3rm3Cj0uNiMmjMVQiL0doJDQZ1JU9et+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzucIiKjD8CZU2OarQRq+aAYv9hTvT4gHCvGTZNu5uo=;
 b=jWXmsWsJblvihx1KJJL0Cbsgehc1pIinIsonHawtvKQLO4UudBLLGE67iZytuKuf4z6ElQmaz7qURRxlwOPa3SAB6MpMfso3ZFoEyhz1cA2xWeFVOHaeuOQUO1HXFHbw0u2aUS1b810aPZTgJDKYL1DrCfmo5fOHV0dJslDHr4hTx+zGcurnSHq2EA5fMl0SgxiytpAPqfajAlniq3AlUVb1rhX61QPnKYi2Y6GotbGy1dYTkrxcXxjJjVnHmuKEEhDiVAN9iW9zhtcrTKci8Q78F8H1fdz26fpHGI0uIF1tEAbGfkaNiYODcJTiwf56qkdgqle7n6MtmVjKlcRA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CH3PR11MB7322.namprd11.prod.outlook.com (2603:10b6:610:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 12:03:05 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 12:03:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 26/40] KVM: x86: Move the bulk of MSR specific code
 from x86.c to msrs.{c,h}
Thread-Topic: [PATCH v3 26/40] KVM: x86: Move the bulk of MSR specific code
 from x86.c to msrs.{c,h}
Thread-Index: AQHc77nG0LBpJFQ17kOjacmvNAL9bbYuVL2A
Date: Thu, 4 Jun 2026 12:03:05 +0000
Message-ID: <f8343739cf91898e978b834cf246fa930c05764d.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-27-seanjc@google.com>
In-Reply-To: <20260529222223.870923-27-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CH3PR11MB7322:EE_
x-ms-office365-filtering-correlation-id: 8f88a5cd-5db7-4b9b-af27-08dec2313c6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: Do+on4AZLUSoozcyTinK7IFDUypfZ/BP/x9COiCuuvi6tbtHofK4Ut/19lHEUpihbfR1IFDr5jh2gm9awXjAPvdTvwm4LDxxabjh26vSE1kI7NbVh0N1IFdfT5rRifTo5OmbMW1oByosfsygWpE0DzYNOVujqR0Cfu3UUf29m6ivgsrU1kEOQNJ88Fa1WL5P5+dXRC5DmksOIWAY8bT15LlNO4UfVh8O7qbURT8qF7PWs9iw+RswablhQsJiSjAEnkzVy9eEF9tbP8ScIJxAYyFzlKIYKpR6cWFR5SpXm/xasZsIX9vrznYhM/BHjiSSKLjAuR2RdLMKW/uo4zzE04XSANITLmlry3NDattL8Tydi1/YOLUtSXwoncBgde/Z5SBzCp7tvR1w5p9zzevxD9Xfj4G7wdiBehUh1kvJIinfLKQg/mgs3Yqsy6fkhDjYSrJRW0dlXjRFo3yZxuPVFL2gfxoPA6nWl9fSe1itT+qNtGpbcoU4f/MJK/YJIowy4dtlKyBgIDh0aUEnqaMVEp0Z+f5zgm0Z5WfteP1joz+qlflYDP/8mAYR0uJ9Sr9FJ0lU9JkLOjALIJ5y2bxs5pYP8cjJ3TnCmd40cOqSKRt9MQFwwjLZfKTKgzZ1DbRRub8LMf8Nrfl4AzRV4sPh39rJoMImvglc6iKMuvWn4RDphlm/esqNUnJGokzXeWMaTqWr/S+rIcm+BlmbxAwEw9u9fDd/JBm3ueUgpu+CEF77DzBum9L5XXjbASYS+9Xv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkhhUWF0T2RzanRzSlh1TWdXbWF2dWlibytEYlFwT3llcXNIcm8ydmZmMTZ4?=
 =?utf-8?B?SmR6aXlPNi9KRHhDNU9qSHBJWWJvcU53ejByLzdqRlFHc0lxWnBIa1Y0Z0dR?=
 =?utf-8?B?cndDb2ttbk5FeGJ6cXd1aWJLT0NrMzB4akRYWTY4cUlqc3hvdjBFZ2trYXo3?=
 =?utf-8?B?c3V5M3UvRGxQcXhEZjRLUWdDamRoSi9LWGlhTkJLV25vdTc2ZjhTeUxNTXRF?=
 =?utf-8?B?YjJLYzZZcmxKaW5QMmNQc3ovUTlxWG04Q29GUlVFNkYwNjRJNy9nQk9HeXZn?=
 =?utf-8?B?NTFBa1lFU1Q1c2FCaGNsOFdCUS9PUE40OHpQMjlhd1VkekdmTUNJVmVnT29J?=
 =?utf-8?B?cUh0Wm9xRjFpdWpVWmtvaGVFK2swOGhmT2E1b0lvTkM4bU5ERllNYWZWenpl?=
 =?utf-8?B?RmhQemh5OVRySk9acVJkSmhDS05HTDFrYjhaK0gvQ3g4em1NZ1dBQkF4UUV1?=
 =?utf-8?B?QmhaMyt0b3VSemdUWDhaNVNMY0puWURuNjhJMGFIUE5CSTJsQmNXdHdJeDF5?=
 =?utf-8?B?SVJ4WE5UWk13Qkg3eEpQWE5nd1N5c3NLOUM5azl3L3FNNFhoWXlpak8ySTN2?=
 =?utf-8?B?b0ppYmJsUW45OTVhd0xrOVh2cW1BbUtyOGgyMTErR2hya044NXN1R21QOUxr?=
 =?utf-8?B?Mm1rRjlYcFE0Z2VmbmNIRDlITEpIWFJEa1NzWXZXN1J6dUxyM2R4a3RUUTVs?=
 =?utf-8?B?K3A4WVAwdGJJeVNHanB0VGt4L1dORFdxc2JQQm1vM2RKY2pvNXQwVE9ZNUhn?=
 =?utf-8?B?MTFLMW1NOXE3aUd2TGdSWTZucTVLTFcxMHQrWmdIZWJnQld0S1ZyOVpmbWpP?=
 =?utf-8?B?aDZDT2k1NGFtMitmcGl1R294TmVOUkQwcVp2QWNmNjEwd3g5ODVlc2wweVFm?=
 =?utf-8?B?SkFoYmp0SHA0clJGcmNhUnF1TlkwODVza2plSFJINEF0L0pLYThlSWdKSjEy?=
 =?utf-8?B?V0xqcjU1SEZUTTNuWS9hMmJ6bEdXaFVDdjBxUGhpVnYxenQ4eERnWXp5YW5l?=
 =?utf-8?B?YUpHNVlpNjRET01CbzZqdU1nVktta09PRWJkbFRWTmVIcFpieTlsM09aekRo?=
 =?utf-8?B?T2xkUzRjcHhxenRiKzJ0bDZyMEg1OVJ1MXVQS0UwNnIwTllGNjdpNHpwYXZW?=
 =?utf-8?B?a21ScWpkZUZTajkrNzUva0d0QjFpMkFsZTBVMkhZVERhZW5sTDh0ZVFub0NP?=
 =?utf-8?B?aUZ0ZzhBTmd4Nm5IQjhQZ1E1WlVVL055VUpzM1pzS2hiSGRMdGVwS2tiSXNp?=
 =?utf-8?B?cDluZDNHVTM5ZU1OSks3TzQySWIwRVpuT01NNDV0OEdWYW9kV3RjTEl2czll?=
 =?utf-8?B?Q2RZN28zUVJhenNXb0hjV2tMTnBHMkhZaWwxTlg2SE5Wb1pGWEJGS3RHRDd2?=
 =?utf-8?B?OVFJUy8yalk3eFY1SFd5OTRjSzEzNFJlZzlrcWd6NjJZbStIaFcvbTBWL21p?=
 =?utf-8?B?RDh2MGdWVmhLU3ZsK2tnRlNhWC9pU25zSmpGSTM0UVk3K28wNi9VRjhhRXBy?=
 =?utf-8?B?cXZXRUFPbjdvNmoyRVdUOEJUbFpnZDk4enlvS2lLMnljUVlGSmZBNXpMQXRY?=
 =?utf-8?B?aDRXNWlWNmE0VU1yVHJvT3gxNW04aDg5NHRKakM0VnRwaHh5U2t4R01DSWZT?=
 =?utf-8?B?NUorYUJHa3ZiYzJxc0tUVnZSd0xyTFNBeCtlVHpXck5GaVUzREtFZzZrMjkx?=
 =?utf-8?B?RkpnRllISlVwNThMd29pRVRtVHgzNHo2K1h4WmI2V1haSTAvTHVCOWt2WE9w?=
 =?utf-8?B?N1FZYVhEdWZBZmRsMzVtZHRYUGRkSys2azV3ZmJaUmJ1dER0azFTWmhRN3JT?=
 =?utf-8?B?VXZyVDZGYWpQcjRhMmRvWFBuWmcvM0FmR0hkMTJSMFg0bFFKTnRESVNxM2xY?=
 =?utf-8?B?YWNpNWxJYlFHWk1PeUF5TVRoR3l2RWZGRHlDSFpsWXFyVTBUV294Nkg3YnFS?=
 =?utf-8?B?cWJOQTVacGsxNTVYajV5bGNWMFRCdCsxZXdQUnpvMjFKSHp4aGJpV2E4aUVF?=
 =?utf-8?B?Qmt5YjdCVEdjdVo0K3lCRndqSDlweURjYy9mRVpobUdkWko2Y2FUSXNWa1hn?=
 =?utf-8?B?Wk9XRVJpbStLZWt0YmdUVGFOU0VPV25OYUdwZXhiek40SHh3S2N6MGNEWVVI?=
 =?utf-8?B?ZDF6aVhXMUdXN1FEd2FzdU9kcGFxdU1kTGtGRlZEYU1abzI1TzBFejB3NnZa?=
 =?utf-8?B?eGtRU1huVFFNdTdMWHRtMHZpZWhOdStuME9NZzZiam9WYnB3VUdQNUhicGg5?=
 =?utf-8?B?SkMvdWJaR3Y5bjVZRG9xRC9mNmlLU1hTWnJmcDVBMHF2KzRndTF5YzJ0K2FE?=
 =?utf-8?B?b2dyN3lSYU53YTk0ZXpCV2R5Uzk2dklhWC9qc3VzbVdaTGJwZkxWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF0BF930FB5257438831BDD2EA260F17@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GR53958iQt7WS8TLc1Xuyq13j8aN9m2EU4RyaN5fJ3q9XFYtMfUk5bheWP1ByleOSPYflDqRfvZhmYFP62tP4WCovVw4MVIpuBGONJYuHlbxPlzbwzzckBEpncCiHjNqXf4Y1ZcQpec5Ceku44EuyWf7cXdjp7mLdnuLLrYkGPvqIysmE/+evDDGQ6HTL6UZ1+qxz/fU5soia2WEN6h/mXcPdZeKQQQCaX/A5PgcPdunFYfA7r6yO8HdSBwoTFUyUqHZGFJ82Tb2UiqTYr4PRa2bFIbWiCYBj2QcTUw7F4uJL8EBHhJV6y7/gXKiSQ9HEGF1Ac5/iuANbrT2V7lMdA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f88a5cd-5db7-4b9b-af27-08dec2313c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 12:03:05.5917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Y0/MJc40asDeml8iA1DtO2ycqng/E7IsMGRli2vFs6Ox9vn2na+dY6i2PdwvumzcvGzkTuuyPQRfxDwzDb7lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7322
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBJbnRyb2R1Y2UgbXNycy57YyxofSwgYW5kIG1vdmUgdGhlIHZhc3QgbWFqb3JpdHkg
b2YgTVNSIHNwZWNpZmljIGNvZGUgb3V0DQo+IG9mIHg4Ni57YyxofS4gIFVzZSBhIHBsdXJhbCAi
bXNycyIgaW5zdGVhZCBvZiBqdXN0ICJtc3IiIHRvIGJlIGNvbnNpc3RlbnQNCj4gd2l0aCByZWdz
LntjLGh9LCBhbmQgdG8gbWFrZSBpdCBlYXNpZXIgdG8gZGlmZmVyZW50aWF0ZSBLVk0ncyBjb2Rl
IGZyb20gdGhlDQo+IG90aGVyIDUrIG1zci5jIGZpbGVzIGluIHRoZSBrZXJuZWwuDQo+IA0KPiBO
byBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4g
Q2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KDQpUcmllZCBiZXN0IHRvIHJldmll
dywgc2VlbXMgZmluZToNCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVs
LmNvbT4NCg0KWy4uLl0NCg0KPiArc3RhdGljIGlubGluZSBib29sIGt2bV9pc192YWxpZF91X3Nf
Y2V0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTY0IGRhdGEpDQo+ICt7DQo+ICsJaWYgKGRhdGEg
JiBDRVRfVVNfUkVTRVJWRURfQklUUykNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArCWlmICghZ3Vl
c3RfY3B1X2NhcF9oYXModmNwdSwgWDg2X0ZFQVRVUkVfU0hTVEspICYmDQo+ICsJICAgIChkYXRh
ICYgQ0VUX1VTX1NIU1RLX01BU0tfQklUUykpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKwlpZiAo
IWd1ZXN0X2NwdV9jYXBfaGFzKHZjcHUsIFg4Nl9GRUFUVVJFX0lCVCkgJiYNCj4gKwkgICAgKGRh
dGEgJiBDRVRfVVNfSUJUX01BU0tfQklUUykpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKwlpZiAo
IUlTX0FMSUdORUQoQ0VUX1VTX0xFR0FDWV9CSVRNQVBfQkFTRShkYXRhKSwgNCkpDQo+ICsJCXJl
dHVybiBmYWxzZTsNCj4gKwkvKiBJQlQgY2FuIGJlIHN1cHByZXNzZWQgaWZmIHRoZSBUUkFDS0VS
IGlzbid0IFdBSVRfRU5EQlIuICovDQo+ICsJaWYgKChkYXRhICYgQ0VUX1NVUFBSRVNTKSAmJiAo
ZGF0YSAmIENFVF9XQUlUX0VOREJSKSkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJcmV0
dXJuIHRydWU7DQo+ICt9DQoNCk5pdDogQUZBSUNUIHRoZSBwdXJwb3NlIG9mIHRoaXMgYmVpbmcg
aW4gbXNycy5oIGlzIGl0IGlzIGFsc28gdXNlZCBieQ0Kdm14L25lc3RlZC5jLiAgTm90IHN1cmUg
d2hldGhlciB5b3Ugd2FudCB0byBleHBsaWNpdGx5IGluY2x1ZGUgIm1zcnMuaCIgaW4NCnZteC9u
ZXN0ZWQuYw0KDQo+ICsNCj4gKyNlbmRpZg0KPiBcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUN
Cg0KTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KDQoNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2t2bS9tdHJyLmMgYi9hcmNoL3g4Ni9rdm0vbXRyci5jDQo+IGluZGV4IDZmNzRlMmIyN2MxZS4u
NGYzYjdiMGY2NTY1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0vbXRyci5jDQo+ICsrKyBi
L2FyY2gveDg2L2t2bS9tdHJyLmMNCj4gQEAgLTE5LDYgKzE5LDcgQEANCj4gICNpbmNsdWRlIDxh
c20vbXRyci5oPg0KPiAgDQo+ICAjaW5jbHVkZSAiY3B1aWQuaCINCj4gKyNpbmNsdWRlICJtc3Jz
LmgiDQo+ICAjaW5jbHVkZSAieDg2LmgiDQoNClNlZW1zICJ4ODYuaCIgaXMgbm90IG5lZWRlZCBh
bnltb3JlLg0KDQoNClsuLi5dDQoNCj4gIA0KPiAgc3RhdGljIERFRklORV9NVVRFWCh2ZW5kb3Jf
bW9kdWxlX2xvY2spOw0KPiAtDQo+ICBzdHJ1Y3Qga3ZtX3g4Nl9vcHMga3ZtX3g4Nl9vcHMgX19y
ZWFkX21vc3RseTsNCg0KTml0IG9mIG5pdDogc2VlbXMgdW5pbnRlbmRlZCBjaGFuZ2UuDQo=
