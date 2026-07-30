Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F47330D25;
	Thu, 30 Jul 2026 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785371033; cv=fail; b=Eg1adSgPiVa3WotxHcQFd1DWcZNmH/ZboKdk5fEO9yMy4KwgWmaem7XPm8V7fABpLVej48m+6mcqUzGW6Hq7KK79QsPoh6unKBpS9N8OOFiYyzgm8gl7eeitg0YV9kVI1C35ES5O98WvHhnLXd9n3NL82TbcBdtSm0p16VabpWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785371033; c=relaxed/simple;
	bh=JTfrWZ/MlZf3vJjgauWvQBDPbRmhreUw1cTHIC5B4pE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sat2FFLihXabM7prXRYpTzxkKq9HUG4mqAeqOlL8qe+CACuFMqHYNbEMJb0J0wzfYPGckggjJk9JWPfo6zgGTgYHzB555ulCOmXEPdRwfa0Ek9jKys6gzEyHYVekAu/ZJssL4rOOF4eXu1CfWz9W2MS9AujKSha6q3wp/66pOrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ka+W32ix; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ka+W32ix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785371027; x=1816907027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JTfrWZ/MlZf3vJjgauWvQBDPbRmhreUw1cTHIC5B4pE=;
  b=ka+W32ixy1WiNqAwAE6EERsHdDNR7TPx7t398pTnUxonT+V3e+cc5Q9N
   4proKFhk2kt2euNSJRBRFoliDWFXg2BsUwka07DQ6aR5FlVt2Koz/lhqB
   wEH0EopBzCMXONLVd3QkYR7YYsJRLJHr0SGtht5aphzer4u5vlJAog14O
   8E/Q8aJdAh4DXVjN6xbKG5HCBieAjPx92Gv3++Lkdvg5/TfJNweUq96xd
   gkdd+/l+xdJsdcaLa/LQmOkz4GkSvueNepTmCGrwAQjwmlsIkPgbEpjtc
   9qCmyeoNTsVnukHaDK8CWqGq3gW6K6cQy/IScDLQOE1T0p9cIgSshDZjE
   A==;
X-CSE-ConnectionGUID: HWoZwqOlRPyj+VBRrmbm9Q==
X-CSE-MsgGUID: H7Vg2G37RFOTcXAHq2F47g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86003856"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="86003856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 17:23:44 -0700
X-CSE-ConnectionGUID: Ww4hlxFaQcKN0cC5pf5nWw==
X-CSE-MsgGUID: 1CxxnTpgQrKvtUBR9WSLBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="290102522"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 17:23:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 17:23:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 17:23:43 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 17:23:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5H1Wc12fmfAP2RrzCPBpc9MEerwjBChrJyQL1scjRjs9DdOg+aE7658y16TKcz7MzVnY43BiMxM22Lgxt1hpUu9sSk156MGwPiJRcgpEtZMF+AvzjjzNl6kR+/3Tt7Q59QNkKgcmo+3R5MXcfJo1FFB0egcHEPM/1oea7M+Z7Q4qZPycMQdjPaz1SPxkhZy/7RVpLEPmSF+Rz1JBn2vKnPkf7hzA1xH2ojIo4Qh5DJwLBOJexCjIWErI1INOiF05ILcT3PJM8ICH5dnH2fMqJn0zdRl+3eIl1SfMV7coPB8ZxKOWAE5tvPLlU3pWDYUuuWpDdlX/tFS7rV1Y8MxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTfrWZ/MlZf3vJjgauWvQBDPbRmhreUw1cTHIC5B4pE=;
 b=XOTL5HrWZyRrbvi5wEnDf+QbCagehUwUQC0Ht5mCvIiJGGUraOReyaTNgMCKTfmUMyUHjLQO8yASjzM6nNz/+GrJmPJbV8SpopA90H4TxYjw2tSLmDIqoYYH3uqVaTtHsqPikPWrYT3fq76nmv/2FmddwXzD5jk5WWE9mz9Ac3dLUKitWe41DiKExJE1MYvzr7WSqpCyF5KiGwR+NHAkWiz3+ExP0q6QisAcJ+uvqJSPIuiSTSadVymKTfXL6UGhq1q5PzwL0SiZpNpUQ2xko9HigUxO8m4AQUMf9Me7I/zOkxGOGO+s+NdHMlUlQ5u4AZISMJqMHGtdKIdSs6Oj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 PH3PPF67C992ECC.namprd11.prod.outlook.com (2603:10b6:518:1::d28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 00:23:33 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 00:23:33 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dmaluka@chromium.org" <dmaluka@chromium.org>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "aashish@aashishsharma.net"
	<aashish@aashishsharma.net>, "jaszczyk@chromium.org" <jaszczyk@chromium.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"vineeth@bitbyteword.org" <vineeth@bitbyteword.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"naveen@kernel.org" <naveen@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Dong,
 Chuanxiao" <chuanxiao.dong@intel.com>
Subject: Re: [PATCH v2 1/2] KVM: Check for duplicate vcpu_id as early as
 possible
Thread-Topic: [PATCH v2 1/2] KVM: Check for duplicate vcpu_id as early as
 possible
Thread-Index: AQHdH3yiVTd52a3D10KPhgo+kDqdlLaFNFIA
Date: Thu, 30 Jul 2026 00:23:33 +0000
Message-ID: <458a4356ba13f191b8a81a22c74e9bc109ae4afd.camel@intel.com>
References: <20260729170621.308809-1-dmaluka@chromium.org>
	 <20260729170621.308809-2-dmaluka@chromium.org>
In-Reply-To: <20260729170621.308809-2-dmaluka@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|PH3PPF67C992ECC:EE_
x-ms-office365-filtering-correlation-id: 3e4b321d-4900-4c6d-c9cb-08deedd0ca62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 5otAbuZK7MPnxl8qcZB5oHo0N6JKiV4jed4jgGEIbgoagdMoj2AnKWbWTWF4D4fWh9T9AqKHsEpUvR70ORWJ1wJrh3MQnvsJFkQLgrD/6EQ7zoGsSTHCzdv8GMeyaPYw5kAT2CWhWRjWurd1VMcu6ZTYUbatDAxb+8m404u2QLQcOsruR8e1WvT5zJID3ldmdbpGGxTC67vrb2fy8V/jOnZQoGy2lQwW2MwuaWhSyn+qLLoMrxJgM5CkcfM04wqmDLfQnM2IBEzh8AeimCSDLuRWDBfsV4gbY7zWNmZyq5NZ3afDl8bjy6bYZms5HqkHQq/S5Pn7zULx9XL8HHRZTrh5P7cQ6zZ6P8xTyeL5IIc4IiWKHbRQGUIQMc72bUnM4c+xSZjelB/ykNqhseW6GC63hdJZsbSmNSkZKIOTAcBZFEC723ytDojrwa06sF/BDGH4N+MVy7TwopzrJYtqaAhCbz4YqbHlaw42x9MZr+zghot/y+RhiPavagfmoVPBFvY20dVmfIRXJcdkz8Ltgmbj2q5DVogcctNL7Y7+kJuK9Vlqjzd3XNHBYWYQW5oLrmqngjYJbEX5qJR8nAp4ltKku83ZQgsGHIwPfOi8IyUcFY38dm80IMdHWNj7tsPQ2/lhS5swZtJl7qD9yWihcgZ9nSOn2YGHS1Ps+YXlvxLDPIoxkknsCJk2nLSewpPxfbAo4vQjjxHSWINmdlfNj8rMDD+n+83wdFwxLarzEVc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWFzYzRzazJHcHFoeGRnNTJ5OGhMRkY5SkJuTWJMV2V0Q1h1TjBQTnJwSWh5?=
 =?utf-8?B?Ly9BMkl1VDFvNG1BWlFkUDI2V2NnMjVXdHVGTU1DN3J5bFpNeWhJRVZsc1hU?=
 =?utf-8?B?ai9sTjZzbGhkc1lzalBRU0NvOEU3OWYyZmdrZG9hMitzdm5jNDkzcWF6YlZ6?=
 =?utf-8?B?MHErZEFlN1ZyS1Y5NkpSc1NRSGtYbkdQRFVXMDBMNUt0WGlPU0M4MEtLSzJO?=
 =?utf-8?B?RDVaQ0pYc0M5cHV0a2NMMXdWTEl2TS9xOWRCNitNdnV0TGV6MnphcEJTZk5Q?=
 =?utf-8?B?QTdZWDd6YmJ0bjZGQnVDMWdUODUydTdjTDFzT2NKaUZqYzZidUYreTZHNlZt?=
 =?utf-8?B?OVE2ZUk3WEs0VHdFMGpUTzNPSmxLakhZU3RnL1FNNGN5SzVCWTE3TDVMUGdS?=
 =?utf-8?B?N2tyMUVubEYyNUxMOHEweWkrOWVWdGNtSUlRQzNKeC9Mc1hqUHhZVk93Rkxs?=
 =?utf-8?B?QWpYUTVYVzRIaVZ2dERoVEFqUkRMMDcyRzZMU1VkR3E3bjB2UDNOcmVza29Y?=
 =?utf-8?B?UGFQU3dDVktNaitjWitBc1ZUbVduVzNtMFROK2d5a2I3RFY1T25ka00yNHlC?=
 =?utf-8?B?YUFOVmVNVGNYcTlrMHgzNUtqRHNnbG1lV1J3UUJuRktIVE9TWVdrcjhDV0lj?=
 =?utf-8?B?c0RIVHhSb2xpWTJjdzA5N1c2alFGbWc2N1o0dmVtKzhvQnUyUHJBVXphZ0hZ?=
 =?utf-8?B?UGdtRGYyQUdHYmYxc2tKZHNCem5OSy90REIrZlRLV21saGRKWDFia1J6b1NG?=
 =?utf-8?B?UnBGNUd3MkdHUUFacGxJc3N5T29vY0pXcTVlL3pkZ3ZlSU4wSW1hOFpSWDc1?=
 =?utf-8?B?VkY1ZUJhd2RsbXBlTGpGQjg1QXVZWkJhVnM5aUxhYlFlTDBYM1JGdXc1Y2tq?=
 =?utf-8?B?MTRrUDk2R0RHc3RyS3BuZjVwWDhSeWdnbE1RdE5uU2FIbFJrSnV1WXZPWFY2?=
 =?utf-8?B?ZmYxS1IvS2NJSjcrQlR2YkpzVGo2N3ljUDZNWXhsTEJ4cVZGSTA2d1dzSG9n?=
 =?utf-8?B?SE1Md01XZkdVajdGUVpsL3pQTW0xS09jNTNTV0FoYWVWRGZ6bW5SaXExT0JQ?=
 =?utf-8?B?ZVAxT09yc1pFd0RpeVU2c0FMMlV3K3NYQ21nNFJINmJadkdBVEZJMmt4dTFh?=
 =?utf-8?B?VXBTSS9obVhHbTBBUzBPMzFJNDUwM2Zhc3UwSXdReFZDZHgzQ2VsM2lPYSs0?=
 =?utf-8?B?ODM4MVRaSXkzUnJFa05KdnFBaldIdXZoYy9PZ3BhRWdjQytYclVWbVU5M0l6?=
 =?utf-8?B?Tlk0a2lIVGpQRy9pSFdtNVNleU1oUjQ1NkRWYU9MVG9HNjdBNGJheld6WE9a?=
 =?utf-8?B?blcra0FGUVY1WWhqZGdQQ1JFenVKZFVzbDdSVzdCSUIwa2JnR3VNT1llc1N5?=
 =?utf-8?B?NU40QVJpenl2REhyK0F1UnhFM3pLc2VqQXl6b3VjcDRHQUpPWDdLTFhlT1Rj?=
 =?utf-8?B?L3V4ZCtjTVZZT0R5aDNpM2Joc0dwUzF6dW0xVTd5a2x6UEsrS0docWtEM3hi?=
 =?utf-8?B?OE5tSVR6RTc4a201VWRBUGl0UGg2NDBZYk1JNGN3RlprQm92WTZtTURFQWRz?=
 =?utf-8?B?MWwwTGwxbkMvU0hsaXFaelkxTjNlU0liUzdMUW5iekNSNzkyQWhuamt0amtE?=
 =?utf-8?B?eS85bmlnbElBOEtNbENuYldUaHZ1aUwwcXptVm4xQUwrWUsrN0toRGtsQ1VK?=
 =?utf-8?B?TkM3RFk4VTF6bjRtWFVhbHRSOVJiS2JkRkZEaXMzQVRhMGxtMkhzZFdPUVRx?=
 =?utf-8?B?M0VIT0VjdWVpUUhIV1dWSFNNR1lvWDlXblpxY09TM3JrVVArYzNKQzQ4MGNj?=
 =?utf-8?B?MjNrR3BicmlYR0dBUjRkT0xYUUlLLytxSEJnY1B4RVRScjZZSGk2bVcvQ1lZ?=
 =?utf-8?B?eHV5MEx5RktBeGc2NXB6TS9YK3pHZThKTDhSK3dudlVRY3BtWGZCcWd4SnVS?=
 =?utf-8?B?SWhjaVJQY0oySVVPVUdLWXlFNG1zbEV2TGRRQlNJTnRSTFNVV1IzWG9qclg3?=
 =?utf-8?B?MklwOXVKTGhSUktoeUM1aTBMQU80ZFhNQWxFdFhPS3ZjVE1vN1laZHd4bGZW?=
 =?utf-8?B?U01SREswVDJpQjFGZ3FEUStFdERhU1RublkzeTV1MVRWZjR4TDRoOCtCWjB3?=
 =?utf-8?B?MHR5WmZFVzNRR3VZTGZGdy9kRXBiejlMU1NHbFVlY1UyQ21DakJqZ1pRMExK?=
 =?utf-8?B?dWVHbnEvdTBZd0l4OVRZRTczSDMya3QveHBhdml6TWZ4Mk85KzBzcURaVzhm?=
 =?utf-8?B?QjFjd1VCZUwxVkovdkllQVlxNExHNFpLWFRCQUtqWGQ0VUtwVjJRelZvRXBx?=
 =?utf-8?B?bXRiaExrYm1wTVBRangvYURSdThEYXhWeUUrWnBlb201N3FxMlhEUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F939436A409054EB9142D5AA55331C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mkVBXVQhnGnOSHxkwkwzbX3xHBrlE+BuypZl1L57zcul5IapREtxQ2v5lD9HB1LkGKuqnrVsZhlHUZryIuczA5VgZL/6BDu2tUNx+ckSAAk3scDYm+svDqC4+IBWoSzOTBxs0VLGAngU2W/VgzyDU9+j5SHpgwG2L9bmy603y7cBuO72atI6/QcFkexvTPogJ0yRXzUxWNQ+a1N2IbUv4n2p+UFwpotSVxo22HF7N3LWgo/h3keU53mTPLngFeaIm9xHyV2f5RHdOM4wCcdhBzl+qGB74FsHjJevApNr7vXQ775NBW8jF6dd7EapoCAOg872Ok3ghMKHwxO4Uj8MiQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4b321d-4900-4c6d-c9cb-08deedd0ca62
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 00:23:33.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IC+cBa8hRi4lp0JdtT1NmY0oKqsixkkfWaR8/Z8g0ntE1/oRA8x+DovpxuPepK6k4407Ouztqaa9RosdbUJMRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF67C992ECC
X-OriginatorOrg: intel.com

PiANCj4gSW4gcGFydGljdWxhciwgdGhpcyBwcmV2ZW50cyBmaXhpbmcgdGhlIFZNWCBJUEl2IGlz
c3VlIGZpeGVkIGluIHRoZSBuZXh0DQo+IHBhdGNoOiANCg0KTml0OiBub3Qgc3VyZSB3aGV0aGVy
IHdlIGNhbiAibmV4dCBwYXRjaCIgaW4gY2hhbmdlbG9nLg0KDQo+IFN1Z2dlc3RlZC1ieTogU2Vh
biBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IExpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2t2bS9hbDZlZzdDLTJzREJFQUZEQGdvb2dsZS5jb20vDQo+IFNpZ25lZC1v
ZmYtYnk6IERteXRybyBNYWx1a2EgPGRtYWx1a2FAY2hyb21pdW0ub3JnPg0KDQpSZXZpZXdlZC1i
eTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
