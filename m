Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405639A05F;
	Tue, 31 Mar 2026 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954938; cv=fail; b=bnjhl2A6RGkIKhmrkgiD0qG44lnFfmL0qSMSAxxea2lhM/ibuUwXDMU6oshz/IiK7AuDBWP8zkf6h4fMjNhR0MpWX3yGVg/JmXRt/PbYdf4vCkdVofWrdRbX6sBQVhYBmjx+rUG03E1y9y10CtLEyCZwYugrGTtmOYcQ2S114Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954938; c=relaxed/simple;
	bh=l2xqB1ic9IlM8Wzf/i4fHf/O66Dw55ovx7hl2cwJjIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ik7ts9XAJgDu4mtn391fqsq6nPAo3I+LehUoVTyVRO73oDsUXMqdY0ss3j0lSKTeJN5jzabJvND4Vi0Ng5RP6YkwXbSTOwFeUNJPF3sThM5eUYc12yOCEDI4TRAi1NkmwMAvITnYAPs3rBKCze7i2K3ujvP0iAU6IfNeK3Up6Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsvoJ+SU; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsvoJ+SU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774954936; x=1806490936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l2xqB1ic9IlM8Wzf/i4fHf/O66Dw55ovx7hl2cwJjIE=;
  b=FsvoJ+SUoxgDqrRzEIZI0CYDkGYVI7kjOc76SrwCOiWGRBBMLFdiKJKP
   CVAB39Gw0ko0XTcm15W4TO1SkWhZjbU+lDUQGFopG3gJ8oGjtyTY7cV0B
   m3wmlY8Df6/RQvmGMfRb0qoG/aPsuCT2LXhRPmP5bonilRoXqGgfmlvMw
   5xmjLxzrJQOtRMkmPdLZ81S9zBMCZ+xANZzUWG+lE1tLhgKlRz2JPH1mb
   J1m31N3jRnu7XkhqjmLporNmE4cB1wq7+GVEC12qtOt/QKn9ZwsK/2Bjm
   VP5PxIHQ2ojzSVeoDd0s+VNH61S+x9zthP1ccKMh5LTG6I+TV8hqUUzfr
   Q==;
X-CSE-ConnectionGUID: KQM0FLsdR+yT9hWbzF4zuA==
X-CSE-MsgGUID: 0F5U4dCSTeuAfSUF/vLWJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86579965"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="86579965"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 04:02:15 -0700
X-CSE-ConnectionGUID: 8yP007H0Sra++m2IwBTxZA==
X-CSE-MsgGUID: 6My+a19PR9iKbdn5L+y/rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221469568"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 04:02:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 04:02:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 04:02:15 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 04:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxXH7URcKoyDLddF1Anxr5RDf+1yI6YRlL4TS6vgnClfql89/cXsOsO0MMxGJP3KOLzj4WMDwPBoK4vFNEIIgr4SwcMk6YnXxSkAN/A2jNZy4Wn+il1hJzsySGxMM8VRhZJ0DEGRqSud9+c1bbyOlBwwYWORpwD7SzFFQO0xTM2Z/LGDjX/zcRR6bZ6j7ZxZ9VwcmPYLyPCcdP1DEuAlpeoMSVcSA4qoQPfFihm8PIpf2Niz36jOUm/Fq/3/8a0TguiQI7J+FciFMudUX5wOfmOuOfMFXzO178cQTDexMlop/HSIYuMIjZ8uWPkEG0Hiykmkypd3EZffvvP/NouaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2xqB1ic9IlM8Wzf/i4fHf/O66Dw55ovx7hl2cwJjIE=;
 b=b5ihgH+WGJ6hEvdaXK7Kq2e82CegONcHzQeZjYmJF/Mp9NdGeJ1BdwuVRtws4f5c9f0z+uSEKzNVn9KlHQJo5LRvnsRB5WEWYWa0hSYTX7R1F98EYuA6PWe9cBhzRxbgWHJQO0JpSqOlyTW5HkgS2frlYxlQ5bHpOgOw15mJRXxgM6dkyWhj7DGEVD4F/on3VgAhHvkFUBJi9KOjsrrqhVxbVKb2GOpz3P2pzMi2d0KtPfdiqYHBW2DT72T54p+WGe9z8r2yDfGkuTONlmegIc9InxWVO0uMrGWg3WtF8c8RpBMxqIP62Rm/Sn19qLrMvgt6+0738tTPyFMdRoZPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SN7PR11MB6947.namprd11.prod.outlook.com (2603:10b6:806:2aa::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Tue, 31 Mar 2026 11:02:12 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Tue, 31 Mar 2026
 11:02:12 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 17/17] KVM: TDX: Move external page table freeing to TDX
 code
Thread-Topic: [PATCH 17/17] KVM: TDX: Move external page table freeing to TDX
 code
Thread-Index: AQHcviZZzc1bSAHk70iq1rD3SClMqbXIf1aA
Date: Tue, 31 Mar 2026 11:02:11 +0000
Message-ID: <04a6d09653719e4ad78ddbb40136b38434dda9a9.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-18-rick.p.edgecombe@intel.com>
In-Reply-To: <20260327201421.2824383-18-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SN7PR11MB6947:EE_
x-ms-office365-filtering-correlation-id: faa24e92-5ded-4acc-b85a-08de8f14f5da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: q5pGbLhXz9TC3XC1AxPZ/uwudxaNfMLXsUtSULHJAxweegWyP2vEDlo1FmZG5v+f5F44FUc7guyu9kUWEijkhpYbYKUY5xmHKxejqhU7bVqTZ2ECvudAvZQ5sjZQunP/I6pQhaC83SDso6MilzB9oxqaFwi1cgLocFC7GaHpJqnCkeC2E90BV/Gl9WUopvIiHTTSk4/Z1hV7G9Fi8twiBF/kCr62YQ6gg7+vTtAaT0RlokgCDP/0pDSfbjwGqhJRCsue5f3IZhmEACQFRVGQ8YeiI3jYolPdVC3QzRUungSa2Jq4Y7Z8SQoeAkMOgqsYpQgK3s4PNh9xSHphjnaVy6Y71fx7I8bYJc6fDl8Be7+KsRMR1bkDFMGiZ/tsGP00O+p2yQ/S1X9in48OWwyUho5iClH1uigXqvcC6Ury089wxv+78zsAgMlGXbggMRICa2bdjlQgI4Iz5OkA3woDkmeKum7C4ywtF2Y0d629hueOwq9gmZY7rHV7PsEi1yAGAgsvZ3n61HtNBNb1LdxaskLm3wCKm190U7MlPBgGlPTuA8xZOaI1xnzKPM/A1jlCsQaMURc9TTF43rZA3HK1V/P5aXL9UoqhhcPHPfxQJYyFeH3JkMlI7tyb2xXuSOUcs5oPcl5o3/NcbPaIJ4dW05c7542D8ugnXP5kjZYmzmclLc0GvfnvvrPnlqFu7+vxURcnzdyroTAarSMr3ZtQr5A1bQSR7+uIYDZHaoNsn6vktIc9XPlyo8UbYDGw+z3mVnacIjhdLBDPUK5ZNWqZyJKNI2Hnfn87BYTMh48IAmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDJvL1RuZSs2RGVwYUpmcnN1UWROWkxqZlVURXNyN09IcVFTVkdaWk9HdndN?=
 =?utf-8?B?R3h5REF5T2VqUmhKSTNDeGl5WjBJSFFFUDFLMllwQ0NFU1AzVnd4Qzhta1lO?=
 =?utf-8?B?UXE2Mm8wbCtlREVpVnVINUVIa0ROSzNVUnYxNHZWbk9CemJOd3lERUtseG5N?=
 =?utf-8?B?NXhIM05YYUYxNTYxVVUrZGJ0cDU4RFhFcElZOVJ6TUV4R2dMUmJIekhjbThM?=
 =?utf-8?B?QUZOSHF6WTlLZjJKd0UzV2hpaTdpRkVRMDFqdzZSSnNIU0h3Ty9MckNhd1pI?=
 =?utf-8?B?cHlYdGJPdW9SRWpuZThNMis4eDhKSWJ2and0Rll2b0VnRGtoai80M1puQXR2?=
 =?utf-8?B?Tm1ENm9uUURaaFdBRUljN1NjWnJQS2Z5VDVOd3lLcGtFSVd2eC9xQkJUeXVt?=
 =?utf-8?B?Q21YOTN6YjQvaHhTak85cEY5K1VIdCtkNUtNTUxWZjRlYkFMU0pQZGw2WlJB?=
 =?utf-8?B?QkM3TFB6eFNCRWdtTzJWTlNkaERHU0FGMVBqMi95WjZBcEhpb3pnMzdqUFEw?=
 =?utf-8?B?akRhbEhROTdxb2dvL0ZFZWMwaFpMSVBTTnFyU3N3d3c5TzUvaExKdFJQTmJU?=
 =?utf-8?B?T0dscW4vNzkyVldJT0JVcytRUUkxYitpOVc4V3lKTmp2UlBEV3pIUEJzaURX?=
 =?utf-8?B?dEl5RkRsNzNsL3Q4YmkzYTRlb1Z2NHhEa0NENlFOdGs3b0lNbjRtVWhodlFL?=
 =?utf-8?B?djBkdGJjVTZiZEZmYi93Y01HdlVjeS9oR3JZdWo0VWh4QmJRdVk1SkU0NUln?=
 =?utf-8?B?MWVsRXVMRG5QeEFXMU9mV1pCSFBTRFdSZ1BKamxYRkpRTUFlRVlOS3lQT3M0?=
 =?utf-8?B?WGthM1ROd0c3WEFPcHp4U3hpajR1SmdLNnFjNXBReDZyRGtybzUzclBEdU52?=
 =?utf-8?B?Y3BNbVNpbGNucklPcWF6ZUJqdEhyRVdNVitmMVVYUys4ejRiNC9hMkJoQ1da?=
 =?utf-8?B?aVZzRUxYOXlHRkdPcE04bEJoTWRmVUJkdTRYNFJoaDlsaGZlSUdXYTFyRVFt?=
 =?utf-8?B?MFdlQmxWbTdadkdpQ3BqWm9makpzUnY2UVNJZzIvTHpWTCtkenVGU2FRWC9s?=
 =?utf-8?B?VWZDY29NWHo2TUVVZHdnQUZxd0JsOHdiR3FwLzNoT3BITHJ1WHhodldzd3M4?=
 =?utf-8?B?K3FNcWpRL0Z4dTNzU2dLNVE0TVIvMldQSjczd0s5Wll0c2dTZ01SV0g0amkx?=
 =?utf-8?B?T09WRFBUUlNTK0JRYTlBVk52V2VNNWlMYWk5aWpXc0hKSHpBOTVoVm1uUVNB?=
 =?utf-8?B?OUFZaW4wZGVhRWJUOW1wUCtpQTQ2QVdPQnZpZ21hakdjcnNmc2JxZWhlQzM2?=
 =?utf-8?B?TERFRm5WSURaaVlhOXFaVG4rNjVNbDExMTlwUFRaWlhRdlZvWlJsdnhGV1Nh?=
 =?utf-8?B?Z1MydmR6MGx4NWN3R1ZYUXlMNWxuMXYrRjNWOVBGSHlHNHhNbTJBeVRub2Fi?=
 =?utf-8?B?YUpwY0VBcHcrZUFNZDV6NC9BbnRNRkdmem5oZzVnVFh3V2l6RDQyR1hzZUlr?=
 =?utf-8?B?akliWU4vTDl4VW5mdzgyWWljT0xoeGFybWRzQnBMRTR5UXRMMkdxSkNLMGNs?=
 =?utf-8?B?b2hiRDNnSkx6SXBXTEgwdTFHNndUMmsyVnJ4dFlHZEJJbG05UlZrVncrSDh4?=
 =?utf-8?B?ZXlIeU93ZFRpazBpcHJYNWNWN3JLekdnUjNTZmVNUGhVcnZCUUZ5czFQWlJZ?=
 =?utf-8?B?UnZqUXZ5NnVqRk1rRXBOMFJLMkNWT3BiYmtpUzRWUEIvZ3I2R3hHR3dqdEsw?=
 =?utf-8?B?cXJXaFovak1wZWxjamV3dXdPUlNGZ1ZoVmdweFJuV0VEWnNlazhRQWlLbHY4?=
 =?utf-8?B?V2FBK25nZXU0UzNCaEc3eVU5T2FlM0ladERNbE9ONnNSdVcyU2dBL3lMRGFY?=
 =?utf-8?B?Tlp4VjN6bnM3WFo1L2o4NXFpbXUzem1Hb0NFb1FTL3Z1MmMyaHAxc0cva1E4?=
 =?utf-8?B?K29ub0cyTWlteHpvTWVtUGp6T05JNVEyL1drVitYMWpsYitYdzE1S1E1TEdD?=
 =?utf-8?B?M29QRFhSVTFpeDZTVitEVWVWQlV5SG01ZGpPRjZtQ1BUN3BJNTFxRGFtRTBJ?=
 =?utf-8?B?YmxuVUFXQ1EyaWE4eXBZZ3kyM1NKNjc5RC9zb0R5MEh0bHhCTjBEQ1hWM0c0?=
 =?utf-8?B?UkRUdFI5b0VGakJiNzg1LzVLZlNvVFNBUHNSZHdwMU80ek1hVTNYaE1QYU8r?=
 =?utf-8?B?VW1aOElaZGN2UzFJSkJmZURVK1pQRjQwNHNFQWJwMEJtVXNEZnVQVGtDOHRy?=
 =?utf-8?B?TUMyQURvU25MNGJlMGJ5L0l2allQcEhPVVB6R2pBSEhReTNKZlljQnEvZmNy?=
 =?utf-8?B?TWJFQi9ETk9KaEY3OS82T3JlNHRCZlBQOVErQitXSi9SVlZSWTJYUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A62042134A35AA45BCCFDAFC54555196@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dwl+jG1HNhSh8JhVFt7YQxXW+1JxnVJCaipRXOy+jIekpJj+Ko8kjtioBcQCGqp9eg5x4nhn3arEjBg3tsPIWn7bWmo3Zk/LUyresNEpVJCld8qgDIal/NDDdyo2pwSrD/2834Qg6fKEFule22w7eAPA0Kzg7ifJihiEmIF9dUZs4U3oVUvMq63U0ctYoLmQUMVxIUJNbKZ1GnpZF72N6cmM7NBsds3lVz4kvWF3t1JHK6KM30DqWMXE0VSLaC3TixbpKKGHWqBN2u1gPAtSjdEqoU0hH3428bXjRf4KdkmzTh3Qxwn4eia+qhYEhy/cUNDBjNBA4Gxx6I5FRKnPRg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa24e92-5ded-4acc-b85a-08de8f14f5da
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 11:02:11.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzwA9LkLwZTep9h8VOrYDlm3r2kROdn+B7CROtyQVhhJRDJBzE8c6NNCtkNw+q1QwrKDDyEU3X7S2/L//EzREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
X-OriginatorOrg: intel.com

PiANCj4gU28gbW92ZSB0aGUgZnJlZV9wYWdlKCkgY2FsbCB0byBURFggY29kZS4gQ3JlYXRlIGFu
DQo+IHRkcF9tbXVfZnJlZV91bnVzZWRfc3AoKSB0byBhbGxvdyBmb3IgZnJlZWluZyBleHRlcm5h
bCBwYWdlIHRhYmxlcyB0aGF0DQo+IGhhdmUgbmV2ZXIgbGVmdCB0aGUgVERQIE1NVSBjb2RlIChp
LmUuIGRvbuKAmXQgbmVlZCBmcmVlZCBpbiBhIHNwZWNpYWwgd2F5Lg0KPiANCg0KTWlzc2luZyAn
KScgaW4gdGhlIGxhc3Qgc2VudGVuY2UuDQoNCkFsc28sIGRvbid0IG5lZWQgdG8gYmUgZnJlZWQg
Pw0K
