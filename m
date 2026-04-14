Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E96271464;
	Tue, 14 Apr 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206409; cv=fail; b=ihIEIlNAEM9SLEbNHs9FNFPN/TJJI0aCL5V5x2zeL65hkHcmUZd4aXYpkwJOdHa98Ezos634QW2w3l+bAQDrMmTEufaWfHyzKkn70Uqa2i90k7+SYvvxZ+Z09h5Q+N3iLatMUJmsx0UTtCbcyEy6bEKXQDhd8jlBWnWO56XNprI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206409; c=relaxed/simple;
	bh=0Y69503XK4T1Wvw9suuPcuPRdd+XdZUx8xOwJ+xjzvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m9M3dw+7tYj2FuEgZD7yN9dwAs7o6U+LFZ2spc2tFKyUbxEQ8C8/qFYOK+4vGm+5oJAbFiiSY26P1/fMBl0HiNzSo5jIRXpT97wLZs6vq1WJ2NG5z2bLhjnXKXMEMkRgyIghE/GABVoLfnLuaBo7G6GFqIc/OoYdM3bScGdXUYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0UyGIgd; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0UyGIgd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776206407; x=1807742407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0Y69503XK4T1Wvw9suuPcuPRdd+XdZUx8xOwJ+xjzvw=;
  b=l0UyGIgdQyEZhaTRbcJHbL3mgikuCVBk8L1y0MBtfGa4ye5h405Z3UNX
   WUfImIRZI8QpUf236C5OADYIFTPK9ajo/GhD5sUZMb7sewVK5wBqxAsl5
   +kyeFxvd6qnlTXnc27zEKJCYuGLIOWW8gC/tiihEFzEBmP+Yj0BVieKiQ
   xbDohvSlmtUhQaDGwOKzHGv24dB/remIZnYQBY54Hi4hFdik+RAD5dtDb
   GDCv3J25zahpLXJ6ySDtOVbN9t8mRs7Q7LRvBCZVo/NQVnYUJaVumhxlc
   snvhwUGcafR7cQvvntHXdFZ96CFfO/Ut2LJBzJzi24yaKaZnM6xjyJsTF
   g==;
X-CSE-ConnectionGUID: Z9utV07BQnSvWllwbqkaDA==
X-CSE-MsgGUID: 9MIsldhFTA6H8AprBgEtlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77251112"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77251112"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 15:40:06 -0700
X-CSE-ConnectionGUID: Smo7jy2rSr+sEw69jYBc6A==
X-CSE-MsgGUID: 1MeZEC3kRR+NpIW6HwPsZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230458765"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 15:40:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 15:40:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 15:40:05 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 15:40:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXD+nzyfy1vZ25ldvRGTZhu31wfPn6LOQKbe65aseBg9SwjrNEQnEPa6USvDb0teYGoj0ahJLe5TeQxWksMcbRUGEjVAchhFNXFcXufuHXE3CiDgQrFX0clfzyBbXv0R2Xt50VpaLgDDpwb+c9f4htxsIqvmulUeT77sl8OeThGvB65MQfJXPuu54gAiL/5yy+gl2TU15Y0Hdv7Q3KJ5M2rUNbBDD/B5JqL6r1jrqPPz+rjPl46WteDVaxKoc870ojnttpMuJw8r76bH3voXR81LUiGsVuaTa+n7RMXCsrlK65XVu9MUDsABiYiqvZ4hNyDidF3EUeavR5ohMCO0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y69503XK4T1Wvw9suuPcuPRdd+XdZUx8xOwJ+xjzvw=;
 b=f7G8EeoL3GH1bgORfuhF7kkZYIK7uJnhfyE6DEqYKw4IFP1ltNIIhQghWFnZ0uVg99bqZKMD1q7tQbNDrd8usl+RyDwySWmRSgHntTlC3S16x3UcMgky31QX8ydTJfdQmbvmQjLNxIbDWnUDAhgSTfxKWcwR6dmDN0evt/OIU2y3BY/ozZs4sebM9K/TcjosbteuBtKCp1i4WAT8P8H/vXxIsX1SK8EZMxjCnqeqW39dJqFGuhnUF2GEw2Dk45kUGbugI0rI4ux917h0vSBiWeKBGcnwiu8zwX7AzW/7OTKdmkmZhl3TVfdjcwA1pi8a0xcjHCgJ0l4Yn317IZ+xPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB8207.namprd11.prod.outlook.com (2603:10b6:8:164::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Tue, 14 Apr 2026 22:40:01 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 22:40:01 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "yosry@kernel.org" <yosry@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
Subject: Re: [PATCH 07/11] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Topic: [PATCH 07/11] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Index: AQHcyHzSXiT5XCiFDUKuKJP/5RyUcbXeP+KAgAB5uYCAAHSpAA==
Date: Tue, 14 Apr 2026 22:40:01 +0000
Message-ID: <8a6aa2a47ae2a56a8a4415c7c4a7f87f2a349fb2.camel@intel.com>
References: <20260409235622.2052730-1-seanjc@google.com>
	 <20260409235622.2052730-8-seanjc@google.com>
	 <04265eaad625a7e594f1f1b273cfde3c90b84934.camel@intel.com>
	 <ad5gYWAQAkkxqOza@google.com>
In-Reply-To: <ad5gYWAQAkkxqOza@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB8207:EE_
x-ms-office365-filtering-correlation-id: 03587368-1b15-4166-2eba-08de9a76c3ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: JfXYGb6oGSvG1RdN40j4cKSwPnj98+JtLPZPe4vQ0r3hE+npU0ztEOpZZGzHE3VMGayLQMLk5VxXJXn3sjWO1zWmHjAtx4ruXTcqWCrEeE87AHW09dPC5pxUlJgt3aBpAlexlPkMBP4eFd1FiRUlJIhrw+l0er2NB2oVlAh1BJYwkijz+fQ49WLPntQOZEfOff3CCCDCG7fReLb9MpX25DcnXBjjDI3gQQH4cJ0k47FXH46BCrpxbu6g3FMAw+ZP4fzpXSjby9/qjKVM6eC/QeL3jck2asPjdAHESuPQbH2QVYcbwj/ACP/ZqGj+k6kE9hipC1UErtSfBhK3GkfmJ9sFfVCjTCjnM9Gcw7wil0Dj/uLGpFdLekFaa7Av8ZUqJHAOYTiu84A4PlL1cb9ZUJJnQ9rsuOMPptQA1p+SPSkBB3oHp1YXfg4MQJwXMMAKVqHvSYQoZmQKgkPUSuMcAYxJ/tyMi/k0aI3Qzo64BWQxz6ZPqXdZ5Zr5VFLuE4brjRgJID23zGXtozz/j9kgn8Xx4mMSc51yq7s33/kiqwyY/5M58Z4w19xR9rxReNLAlARGfZ2iGWL58lFcmESddKzs5CSjyFF5wESTKDZCbkIYAtiQS8gJZ99a7m28Y9RyNgEyEEx6sFDWxwfbN0Wg/5psZ6QJv/uPbwL04LLGIqCdl37JYE6FFrOgCo0WwdlXg3RtrDN1A1lQl8k8yV0OlU4tlpCVfqsV1dTWH9ooms9wGdwDBVksNb9MqPv2iHQswh6LNY+4yOIvKVvGXmZCB5zUu8skjAEF/eAMSJWc5mk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGp3a0pzTWhvRnBPNTBDM2tTRmpvWmZwVWN2RjY3SUpTWG5saGNtcXZRMzEr?=
 =?utf-8?B?T1ZFQlNsY01xL0RLTEVVY2Y0STYyZ0dyN0RnbkxFUm1aYjJYK0xzNERiQU1a?=
 =?utf-8?B?YmhSYUwzRGcxYjlmcnZQZjNaa3YxU2RsaDA0SkZFcVpRakF4QWFFdmNpaWRX?=
 =?utf-8?B?Qi9wem9lYXE5Vnl1WnZ6azlmNmRQUkdxZ0FGNWJsSnRRSUZCYy82ZzlFR3Av?=
 =?utf-8?B?dFJXK3RDVDhSc2V6alJQK1B5RjBQaXE4VDNjT1l3V1VXeXBxTitBZlpaaDZT?=
 =?utf-8?B?Q3cxTWVVbUljZlhjeWZlQTkvemZxSnJrVHltYmVKZ0toaHAxVGZhODZmbmpJ?=
 =?utf-8?B?cFFzNFF6SjZSZlNOZnMzM0xaTEcrMFpHYnRFRWtYamRucGZxRlV2dVV5UVQ1?=
 =?utf-8?B?Qk4xY05JNEd1Z0hydWVXOS9JcWJhVkMrUE1YdFR1NzZ2U2twbHdiS3M0SHA4?=
 =?utf-8?B?czZxVjBENmZ3Z1lJejZ3WXB1MEFNbk9kWFpxRC9LK3M2cDlFMHovVWxYdDNG?=
 =?utf-8?B?YXRKTnlMYzRqR3JXV2RsRFE3U3Q2Y3lxRFR0emtWQmtZbk1CbEE1alVMWm85?=
 =?utf-8?B?RVp1ajE3ejNiSER6MjBmaUtaUHJxeXlIREdlNHRxMFYwMER3a1RwTE90UldB?=
 =?utf-8?B?TVhEcDJzVTRwbGZGelQ3em43UDNOUkxmUUJaa0VtdFNEL3JQMzR6MTZINlFZ?=
 =?utf-8?B?WUpVaWw4UDhOL2ZaRCswdm9ITExvWTFML0ptR3dyOFVJem5VUE9TYTJOSlRR?=
 =?utf-8?B?WWVNUjY3NmVCT2ZtbDJ3cVN2TTNhUWtlVDJMQmE3ejRCTVlFb09uVHZqOFpp?=
 =?utf-8?B?aFJpdkw1WklMRi96NGFTZTlNYWZ3T3JKQ1N3aWc5L2hrV3RDVXFUalU2Zm5N?=
 =?utf-8?B?b1pNc1VKZzBMTGk0RGw1bXJvZXVOZ0RpLzdUL05KZmx4N1lPUmFiNGtmSmVi?=
 =?utf-8?B?VkhpeUZXcW84bkFhQ3FlN0NiTnZLRVU4S0ltQnFEbURjc0xjYWVYMXA2ZmM1?=
 =?utf-8?B?djBVQks5T0tiSzNyZWxQazVObSt0aE91NHpHdGl6VVdURnVzdE0xcmd4a1J2?=
 =?utf-8?B?SWZNVGNxaGZhZ0tOZ2pvY1cxVjVsUzU1Sjhpa3Fnd1hWOTVTc29xSlBUNU4v?=
 =?utf-8?B?K1VQOFY3bUhnTXQyR2hBVXJkK2VXMzVqYlBUaFNlRUlWYU9BTjl4U1pSVytV?=
 =?utf-8?B?QkVDVFFqT2hDb0FaWlhsMnMyRHgxOFpzV2lFVEt3UU5HbDdmMGNrM0lQUWQw?=
 =?utf-8?B?SUtXdUFZVllJb2Y4YVZMVnZBckt1TkhtcE1HUVh3S1MyM21xS2hjekpDbGUx?=
 =?utf-8?B?ZWdCMjY1TU5GRm1GUFhXQXMxL3lHQ1FWbTBnK0RwRURMSVU2U2MwREtjQlNZ?=
 =?utf-8?B?bSt0Y0RNdkd0WlFWc0cydUdJQ0JnZ0JhMVZEeEg5ZTY2cW9nYkRidDBpMWlm?=
 =?utf-8?B?NzV0bGRWWDZ4OXN5TTZNcDNMR0lqZ0dENGZpaEF0eWJjZlBQUUt2Vmpac1FL?=
 =?utf-8?B?ZEZDZUI3eXhUbm1ack81UzZEM0wvaStBb2RMMURMTHZMRnEraUVmWWZDL3Zy?=
 =?utf-8?B?eXlPZWt1aTVxQ0JHQ2VxbElERXprcU1sZGtXckFNVFFWSitiNjE5SHlnb0Js?=
 =?utf-8?B?RzBpMHlUWUpoaEV4THBQOU9QSGxWUE5qQ1ZHcitOS1NLa2xkUDJ5U3dzVXRp?=
 =?utf-8?B?K3pWVkRkSktCU3V6clNMbDc5K0Uyb0lpbmgrU3Vma2NsZ0NWTnVhY0cwQkU2?=
 =?utf-8?B?WG9oK2VBNFJqZmRPVjJ0WXJ1Ry9ZeTg0Umk4QUFDT0hFTTY3YUNRWGlMZTJQ?=
 =?utf-8?B?YmVEbUt0MTk2WjBvemlKeW9UMFd0K3l5R3lwWXF4VmZjelRJVUdCU1ZtRlpG?=
 =?utf-8?B?UnhKRlVVNkJza2RJZXJPQzhPTXRqSEN6RjNCaGswRGE3OC8vMUFka2o3QS9o?=
 =?utf-8?B?Ynl2cVYzQVhEOVRSRmNQNlB4MVRCZnFEM2ZTcEQyS1B1ZTBzOFZLbzAvbldU?=
 =?utf-8?B?WHQ5NjJ3Y2kxUWxhMWJFMEZFVVVOWkRQVUFmN0JJcytVUVVJWkVGeHlybC8x?=
 =?utf-8?B?RFdMT0x3T0JjTzNQTmpCdUUrNUtQRTNvN1JjcE9qZ0plN1ppa2tyMXRiQWkw?=
 =?utf-8?B?SVNQVXhEQlRCOWZjYTBzeldLVVBRWWsrN0liczB1dlg0Y0Z5cnJmcnV4amZN?=
 =?utf-8?B?cjV3NytISTg1UjVEbGVMakhiV3hCaGhRdSthRm5uZENyNmkzOWU2MGkzZUpj?=
 =?utf-8?B?SjBQeUUzT1lLZ0wxcjUwSXpnVEh1cjRMOXJpM2xFYjZobzk1TVFlS0tvNjlm?=
 =?utf-8?B?TlZmTEZEUU5TQ2dFK0k0VmtpajR4eHZWL3YvNzlESmtXOWhXNERRZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E1827890BF95946847841BC3FF0CC8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ogNAx4epNiohjQAG0GXrOd08LOfsy/UgO1cH3v26f5oh053oUf1q7Qyhu006llopGEtGqMmQtc16X0a/jMvy/pz51l6CcFqxuI8Fo/H0QVr2O+Abw5FZZxFVqn7/tLxeCZL9HyrDgm2pQuszI4o3ULcBRWdA2RzSrQaWApWFGUg6gAMX1NpyYnziLwkmRNY7tzCNuzR46SvjDWyO0jvn5HNtp7Z9Bm3Tf3fIjKwfdJ63tv8NZ24XEuM8/Gxb8P641NalqdYcsGSZTVFALlHNy+VoCF4+yF8qpUDr79MMcpJ0zXOteu0D/j0/X9GiSdqKqw4m6nj+Wz/71hUJXGflZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03587368-1b15-4166-2eba-08de9a76c3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 22:40:01.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnZ8Zi7ZcMSsOedBkr1SSB0aDEjzTe966zHSaumR6/sj8K/RS+mny/f7o/0egnLNiq1kFnaEnzaTehJ0GCzNMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8207
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDA4OjQyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUdWUsIEFwciAxNCwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IA0KPiA+
ID4gLS0tIGEvYXJjaC94ODYva3ZtL3N2bS9uZXN0ZWQuYw0KPiA+ID4gKysrIGIvYXJjaC94ODYv
a3ZtL3N2bS9uZXN0ZWQuYw0KPiA+ID4gQEAgLTc1Nyw3ICs3NTcsNyBAQCBzdGF0aWMgdm9pZCBu
ZXN0ZWRfdm1jYjAyX3ByZXBhcmVfc2F2ZShzdHJ1Y3QgdmNwdV9zdm0gKnN2bSkNCj4gPiA+ICAN
Cj4gPiA+ICAJc3ZtLT52Y3B1LmFyY2guY3IyID0gc2F2ZS0+Y3IyOw0KPiA+ID4gIA0KPiA+ID4g
LQlrdm1fcmF4X3dyaXRlKHZjcHUsIHNhdmUtPnJheCk7DQo+ID4gPiArCWt2bV9yYXhfd3JpdGVf
cmF3KHZjcHUsIHNhdmUtPnJheCk7DQo+ID4gPiAgCWt2bV9yc3Bfd3JpdGUodmNwdSwgc2F2ZS0+
cnNwKTsNCj4gPiA+ICAJa3ZtX3JpcF93cml0ZSh2Y3B1LCBzYXZlLT5yaXApOw0KPiA+ID4gIA0K
PiA+ID4gQEAgLTEyMzgsNyArMTIzOCw3IEBAIHN0YXRpYyBpbnQgbmVzdGVkX3N2bV92bWV4aXRf
dXBkYXRlX3ZtY2IxMihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ID4gPiAgCXZtY2IxMi0+c2F2
ZS5yZmxhZ3MgPSBrdm1fZ2V0X3JmbGFncyh2Y3B1KTsNCj4gPiA+ICAJdm1jYjEyLT5zYXZlLnJp
cCAgICA9IGt2bV9yaXBfcmVhZCh2Y3B1KTsNCj4gPiA+ICAJdm1jYjEyLT5zYXZlLnJzcCAgICA9
IGt2bV9yc3BfcmVhZCh2Y3B1KTsNCj4gPiA+IC0Jdm1jYjEyLT5zYXZlLnJheCAgICA9IGt2bV9y
YXhfcmVhZCh2Y3B1KTsNCj4gPiA+ICsJdm1jYjEyLT5zYXZlLnJheCAgICA9IGt2bV9yYXhfcmVh
ZF9yYXcodmNwdSk7DQo+ID4gDQo+ID4gTm90IHN1cmUgd2hldGhlciBpdCBtYXR0ZXJzLCBJIHRo
aW5rIHRoZXJlJ3MgYW4gaW5jb25zaXN0ZW5jeSBoZXJlOg0KPiA+IA0KPiA+IFRoZSAicmF4IiBv
bmUgaGFzICJyYXciIHBvc3RmaXgsIGJ1dCAicnNwIiBkb2Vzbid0LCBkZXNwaXRlIGluIHByYWN0
aWNlIGl0DQo+ID4gaXMgYWxzbyBhICJyYXciIG9wZXJhdGlvbi4gIERpdHRvIGZvciAicmlwIiwg
YWx0aG91Z2ggaXQgd2lsbCBiZSBtb3ZlZCBvdXQNCj4gPiBvZiB0aGUgInJlZ3NbXSIgR1BSIGFy
cmF5Lg0KPiANCj4gT2gsIHRoZXJlJ3MgdmVyeSBtdWNoIGFuIGluY29uc2lzdGVuY3kuICBSSVAg
cHJvYmFibHkgImZpbmUiLCBhcyBpdCBzaG91bGQgYmUNCj4gaW1wb3NzaWJsZSB0byBnZXQgYSA2
NC1iaXQgUklQIGludG8gdGhlIENQVSB3aGVuIGl0J3Mgbm90IGluIDY0LWJpdCBtb2RlLiAgUlNQ
DQo+IGlzIGxpa2VseSBub3QgImZpbmUiLCBpLmUuIHNob3VsZCBwcm9iYWJseSB1c2UgYSAicmF3
IiB2ZXJzaW9uLg0KPiANCj4gQnV0IG1vc3QgaW1wb3J0YW50bHksIGZvciB0aGlzIHBhdGNoLCBJ
IHdhbnQgdG8gYXZvaWQgaW50cm9kdWNpbmcgZnVuY3Rpb25hbA0KPiBjaGFuZ2VzLCB3aGljaCBt
ZWFucyB1c2luZyB0aGUgInJhdyIgdmFyaWFudCB0byByZWFkIFJBWC4NCg0KWWVhaCBtYWtlIHNl
bnNlLg0KDQo+IA0KPiA+IEJ1dCBtYXliZSB0aGV5IGFyZSBkaWZmZXJlbnQ/DQo+ID4gDQo+ID4g
Wy4uLl0NCj4gPiANCj4gPiA+ICAJY2FzZSBFWElUX1JFQVNPTl9NU1JfV1JJVEU6DQo+ID4gPiAt
CQlrdm1fcmN4X3dyaXRlKHZjcHUsIHRkeC0+dnBfZW50ZXJfYXJncy5yMTIpOw0KPiA+ID4gLQkJ
a3ZtX3JheF93cml0ZSh2Y3B1LCB0ZHgtPnZwX2VudGVyX2FyZ3MucjEzICYgLTF1KTsNCj4gPiA+
IC0JCWt2bV9yZHhfd3JpdGUodmNwdSwgdGR4LT52cF9lbnRlcl9hcmdzLnIxMyA+PiAzMik7DQo+
ID4gPiArCQlrdm1fZWN4X3dyaXRlKHZjcHUsIHRkeC0+dnBfZW50ZXJfYXJncy5yMTIpOw0KPiA+
ID4gKwkJa3ZtX2VheF93cml0ZSh2Y3B1LCB0ZHgtPnZwX2VudGVyX2FyZ3MucjEzICYgLTF1KTsN
Cj4gPiANCj4gPiBOaXQ6ICB0aGUgIiYgLTF1IiBpc24ndCBuZWVkZWQgYW55bW9yZSB3aXRoIHVz
aW5nIGt2bV9lYXhfd3JpdGUoKSwgYnV0IG1heWJlDQo+ID4gd2Ugc2hvdWxkIGp1c3QgZm9jdXMg
b24gcmVwbGFjaW5nIHRoZSBmdW5jdGlvbnMgaW4gdGhpcyBwYXRjaCBidXQgbGVhdmUNCj4gPiBj
bGVhbnVwIGluIHRoZSBmdXR1cmUuDQo+IA0KPiBHYWgsIGdvb2QgZXllYmFsbHMuICBJIGludGVu
ZGVkIHRvIGRyb3AgaXQgaGVyZS4NCg0KSWYgeW91IHdhbnQgdG8gZHJvcCBpdCBpbiB0aGlzIHBh
dGNoLCB0aGVuIHRoZXJlJ3MgYW5vdGhlciBvbmUgaW4NCl9fa3ZtX2VtdWxhdGVfcmRtc3IoKToN
Cg0KQEAgLTIxNDAsOCArMjE0MCw4IEBAIHN0YXRpYyBpbnQgX19rdm1fZW11bGF0ZV9yZG1zcihz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsDQp1MzIgbXNyLCBpbnQgcmVnLA0KIAkJdHJhY2Vfa3ZtX21z
cl9yZWFkKG1zciwgZGF0YSk7DQogDQogCQlpZiAocmVnIDwgMCkgew0KLQkJCWt2bV9yYXhfd3Jp
dGUodmNwdSwgZGF0YSAmIC0xdSk7DQotCQkJa3ZtX3JkeF93cml0ZSh2Y3B1LCAoZGF0YSA+PiAz
MikgJiAtMXUpOw0KKwkJCWt2bV9lYXhfd3JpdGUodmNwdSwgZGF0YSAmIC0xdSk7DQorCQkJa3Zt
X2VkeF93cml0ZSh2Y3B1LCAoZGF0YSA+PiAzMikgJiAtMXUpOw0KIAkJfSBlbHNlIHsNCiAJCQlr
dm1fcmVnaXN0ZXJfd3JpdGUodmNwdSwgcmVnLCBkYXRhKTsNCiAJCX0NCj4gDQo+ID4gWy4uLl0N
Cj4gPiANCj4gPiANCj4gPiA+IEBAIC0xMjE4NCwyMyArMTIxODUsMjMgQEAgc3RhdGljIHZvaWQg
X19zZXRfcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm1fcmVncyAqcmVncykN
Cj4gPiA+ICAJdmNwdS0+YXJjaC5lbXVsYXRlX3JlZ3NfbmVlZF9zeW5jX2Zyb21fdmNwdSA9IHRy
dWU7DQo+ID4gPiAgCXZjcHUtPmFyY2guZW11bGF0ZV9yZWdzX25lZWRfc3luY190b192Y3B1ID0g
ZmFsc2U7DQo+ID4gPiAgDQo+ID4gPiAtCWt2bV9yYXhfd3JpdGUodmNwdSwgcmVncy0+cmF4KTsN
Cj4gPiA+IC0Ja3ZtX3JieF93cml0ZSh2Y3B1LCByZWdzLT5yYngpOw0KPiA+ID4gLQlrdm1fcmN4
X3dyaXRlKHZjcHUsIHJlZ3MtPnJjeCk7DQo+ID4gPiAtCWt2bV9yZHhfd3JpdGUodmNwdSwgcmVn
cy0+cmR4KTsNCj4gPiA+IC0Ja3ZtX3JzaV93cml0ZSh2Y3B1LCByZWdzLT5yc2kpOw0KPiA+ID4g
LQlrdm1fcmRpX3dyaXRlKHZjcHUsIHJlZ3MtPnJkaSk7DQo+ID4gPiArCWt2bV9yYXhfd3JpdGVf
cmF3KHZjcHUsIHJlZ3MtPnJheCk7DQo+ID4gPiArCWt2bV9yYnhfd3JpdGVfcmF3KHZjcHUsIHJl
Z3MtPnJieCk7DQo+ID4gPiArCWt2bV9yY3hfd3JpdGVfcmF3KHZjcHUsIHJlZ3MtPnJjeCk7DQo+
ID4gPiArCWt2bV9yZHhfd3JpdGVfcmF3KHZjcHUsIHJlZ3MtPnJkeCk7DQo+ID4gPiArCWt2bV9y
c2lfd3JpdGVfcmF3KHZjcHUsIHJlZ3MtPnJzaSk7DQo+ID4gPiArCWt2bV9yZGlfd3JpdGVfcmF3
KHZjcHUsIHJlZ3MtPnJkaSk7DQo+ID4gPiAgCWt2bV9yc3Bfd3JpdGUodmNwdSwgcmVncy0+cnNw
KTsNCj4gPiA+IC0Ja3ZtX3JicF93cml0ZSh2Y3B1LCByZWdzLT5yYnApOw0KPiA+ID4gKwlrdm1f
cmJwX3dyaXRlX3Jhdyh2Y3B1LCByZWdzLT5yYnApOw0KPiA+ID4gDQo+ID4gDQo+ID4gRGl0dG8s
IHRoZSAicnNwIiBvbmUgc3RhbmRzIG91dC4gOi0pDQo+IA0KPiBZZWFoLCBzYW1lIHRoaW5nIGFz
IGFib3ZlLiAgSSBkb24ndCB0aGluayB0aGUgY3VycmVudGx5IGNvZGUgaXMgMTAwJSBjb3JyZWN0
LCBidXQNCj4gaW4gcHJhY3RpY2UgaXQgcHJvYmFibHkgZG9lc24ndCBtYXR0ZXIuDQo+IA0KPiBJ
ZiB3ZSB3YW50IHRvIGNsZWFuIHVwIFJTUCBoYW5kbGluZywgaXQgc2hvdWxkIGRlZmluaXRlbHkg
YmUgZG9uZSBpbiBhIHNlcGFyYXRlDQo+IHBhdGNoIChvciBwYXRjaGVzLCBwbHVyYWwpLiAgQnV0
IEknbSBoZXNpdGFudCB0byBldmVuIHRyeSwgZXNwZWNpYWxseSBmb3IgdGhpcw0KPiBwYXRoIHNp
bmNlIGl0J3MgdmVyeSBtdWNoIHBhcnQgb2YgS1ZNJ3MgQUJJLiAgSS5lLiBpZiBhaW4ndCBicm9r
ZSwgZG9uJ3QgZml4IGl0Lg0KDQpSaWdodC4NCg0KSSB3YXMgdGhpbmtpbmcgbWF5YmUganVzdCBy
ZW5hbWUgdGhlIFJTUCB2ZXJzaW9uIHRvIGhhdmUgdGhlICJyYXciIHBvc3RmaXgNCmFzIHdlbGws
IGp1c3QgZm9yIGNvbnNpc3RlbmN5LCBidXQgbm8gb3RoZXIgZnVuY3Rpb25hbCBjaGFuZ2VzLg0K
