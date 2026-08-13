Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662E030ACEE;
	Thu, 13 Aug 2026 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664758; cv=fail; b=PvlS6jUXmNVTvI4oqqWgE1EJtXVAW5/dWiADpqgKBVvV7fqB4pvV28Lrr+Uzx7FPmsiK/j2FQkDlS2srUPNRPHPkAEiNB1blt/HJ6vFkThZW4yrKnHLPl2U1LAqmHHMvpRrwQOLA2D4DcKblEP3O0hH87WG1Wmv6lQVLtdQg1+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664758; c=relaxed/simple;
	bh=Ghc41SynpW/yYpvjoUfHNcvn1/pMSCqYQgGJrWzZS14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SgHtsnXkLdvQerlcNZjZNxWllNGclE8qfXEbwf7+3d4WdJ2O8ZkSIdjjaTq+co78XAkOeJk0jBcE95wy4GDhIm3aEXY/LN15t/GTEUBg1xSzdtP8g+NDualWbpq9s+wMr1Z0+u39y1GTF3y3bORDXAqtKj3vw805lC2lZNlZ4YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cII1Sf6y; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cII1Sf6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786664755; x=1818200755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ghc41SynpW/yYpvjoUfHNcvn1/pMSCqYQgGJrWzZS14=;
  b=cII1Sf6yDFK3lbLFDlQjDKhybeihQ/rzW5+P7AqOegAW0ZYjFyccv/p+
   NkSAy0L6KjysOZOBThhVVXKaGeArTJATmeuMatoIODuNCNdBI1MkkYzlK
   7eSW9i4bTiQ+rP56BzCjKSqaOksSXPnYxSS742HtuuAoo/0KTCeYqBQaW
   kaF5Cyxheh6tYa1LG4/eZ7WWkFCtlpX231JxdMgIaV841TLIYITVWgye+
   ApUt96+DXh/hbb/EFnC2kmVA0OkumAzr16XazFqHQ/V4rg5NroXdY8Ewm
   FdwMyUtyl8l3pJYP3nAVJytuw9+UMm+bjVykF1lGYjtD4Grci+VQRHUpM
   A==;
X-CSE-ConnectionGUID: pAk3Ga4dQkelhbk6CNBUyw==
X-CSE-MsgGUID: 07c8Sr+HRcK0hVkwIdYC1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87465807"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87465807"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 16:45:54 -0700
X-CSE-ConnectionGUID: DBFvWZw5T8+5LUJtkuglmA==
X-CSE-MsgGUID: MaO/tA6sTDW44/wjOFuF1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260277944"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 16:45:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 16:45:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 16:45:54 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 16:45:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBm+syf+l4+vGhLRETii7I57w/NbTyzrJ9r9jzy6w61x9zvhSoqPRyQfzLTV9CPONJ7APHziCoNwoW60EvX75leTH8i4mcnDV1JO+TV9RkPaSrrLWMgrRWUKDog2C2jpPuamz9JeAMnNh4Ylh4D3UUaSEd2i+6l0OYtWpybvh//1RaCF0HCUrZqXN2Lry3lk2jJ+/haCfF0xxKoCZMdpXl7PsZ7VKavQCo0/ZXfr4Gcku6STI0/iJtdLREo9ACTtOrdEM220usUqsO0ePf+HlyLD5iHISJ5/U94RAzD/zfbPO4a9ft5jZprnz3rnyZoZe0NoWwn1KbmDjbeHvM371Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ghc41SynpW/yYpvjoUfHNcvn1/pMSCqYQgGJrWzZS14=;
 b=mHjFDvsRANoPka/ZUajpWc/WhENfh+ubL/wYBfhT4+2vtSUb3epj4nshnqOfhwq2XrF19JumFkREN1qLZSC452/sG9VRsOoPzh5jZKYZZOP3rqo93bIpVHYHvAddMIaMePJ27srMPo4sjFnEJWTU2G+L7Kq269DK4DK7lyDGT2SxXhgjkEVA1k3EbxDRjg6bzLjvYTYDJWKh5g4FNEyGRq/dJ4+cAYwUR3d0VUVX73yl5fol0w9gkd/munzz3FWnEPD506i2+ILCI9ZGI6X+KxSWDkNZ8M/vFXipBuXkQRcFhGMApT13GBhkNQz3Fy8KF+lRsl8SrLwdNww7lvXlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 23:45:50 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 23:45:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "seanjc@google.com"
	<seanjc@google.com>, "pratikrajesh.sampat@amd.com"
	<pratikrajesh.sampat@amd.com>, "oupton@kernel.org" <oupton@kernel.org>,
	"wyihan@google.com" <wyihan@google.com>, "sagis@google.com"
	<sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>, "Wang, Roger"
	<runanwang@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 04/22] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES
 to validate TDs' attribute configuration
Thread-Topic: [PATCH v14 04/22] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES
 to validate TDs' attribute configuration
Thread-Index: AQHdGi/fGqtVph/yck2WHhbnWKBB07acx1yA
Date: Thu, 13 Aug 2026 23:45:49 +0000
Message-ID: <ae783977c1eaa34d2910f76dac1437c7aad47d93.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
	 <20260722-tdx-selftests-v14-4-15ad654a50db@google.com>
In-Reply-To: <20260722-tdx-selftests-v14-4-15ad654a50db@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7529:EE_
x-ms-office365-filtering-correlation-id: d50eee0c-b723-42ca-b73f-08def9950134
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|6133799003|22082099003|18002099003|38070700021|11063799006|5023799004|4143699003|56012099006|10067099003;
x-microsoft-antispam-message-info: iJ7WFZoiF18VZ2ERe85uJ4ft9H2c++nmW4vNDxmvGWy02IlzxV7W79dh2bnDjgiwfTljUEkUBFbrl/aeQsEv9ELHTFwIhDJJUeqakL/1zMynklEgJEZJ6OJxnbSRm+Y+Wdi9mU7h2QCSTBQDm6hA7vgmrIdzyryppZnOBlf3rEfwqMYKubggbj6UTy4ZCXr+J0zdFhguMewurh/zLAGOZ2GQ292TLqEERe68BjoSxdx+bFAgz2NEbLxSlYYwYpf/jPR6At97zT06M6ntC6i90XO/tsimOCYizu2TPvkXXltHaWW29NjKv9hRllZOdUSuEb5MM/2S80jlFPYBqYW3y3iP7DgucTBPbMnmCsr07U9X0kClhbG4JrJLFgG58rkto2lcN6P6ZCgTIp/PmdVhhmH8PBKrvZ9Y7uq7ciIxshlSudMsG2ONrYJaBLpRV3L/DMrhUgczWzI8P1fFGoziP+NtbbsWkW/P2K0fXYGXfIvLg06+EZileHI5EuXiMu6XuGU1McOGrYwoQW0heTkCLg/zeP72wSdcW1z+mKa9ry8VAaz0VQNuVwbIPi3TLP1fEAeQuxql9p2GwAmT22pVw5hQJYFRysWm8Kw1eeZj8VtK9Yd5Mg6pkKFa7PeOrEiuKSXkwgHtplo+B9jjbxT/HTojuaNsIlc7Iy93YPTvGxhY3j8kZ4ww12im+DKfn/30ivh943dR5F37JckwCzm8Sr5Wk3aqnod13tmKYVmxbBJnCazwTkd1ikbOxf/VZPAS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(6133799003)(22082099003)(18002099003)(38070700021)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OS80MGo3L291MjhjUE92TU03VnJWYWtDTGtQSlZ4SVhETjhQREV2Rno3ZXFX?=
 =?utf-8?B?a0xqeUZVU1NyMHFPWjJNK3RBTHJ1ZHFrYWNiMnVFOEdtL0R5QW1OSjRJcE5k?=
 =?utf-8?B?VTdrM2RScHpSUjR6Rmk4STBnaW9tK2dxbnNJZ05KdDVvM1pMMGtIbXkycEwv?=
 =?utf-8?B?SExDclBCWFlub2t6dGswcHJhVmxUWktmUzNZczVOeXAramJmWS8xbVdiWHFC?=
 =?utf-8?B?aXloNkdmOUFtRkN2bXNKNE1ibHNBaVBMZ0JQTFFFa252OThqT1Fma0wvT3FT?=
 =?utf-8?B?N0l3cHBHZXZmd00xWFAzcTI5YVF3S2ZLV1cvcGpHWTZ0dVJYK3d0U2ZwZ1Vz?=
 =?utf-8?B?cnNtUlNrcWdySDBjY3B6ZWIzWGc3SGRsV0RvZFN1aFZEZUZ4My82bzZPTGVV?=
 =?utf-8?B?elVpU3U1WWNFTHRvR0Rab0lyUmZqUkZDOHRUSGhxZ2ZLdGhDZXZiWndpb2Za?=
 =?utf-8?B?U0tWVXordC91YWQzTklXcy9jSzNrRzRUYkZWY2N2MUF4SDZPQjkxckNEOGtI?=
 =?utf-8?B?dXZVaFlrb1VPa0hJYStyOWRxOXAwWnZvZlVTaEUwSnhGNmpYWGRLK29YTUdq?=
 =?utf-8?B?ZVlUaHVoUmxCZldvZnhOdjFtV2c1VDBBK21uaE5pc3V2UGdUbUd6b0k5aVI3?=
 =?utf-8?B?TkFpMVdYR2RCUFhReUZULzJMWkxkYW5HZnRIcC9hdmhhRkNSTUt1TDB1MVZt?=
 =?utf-8?B?aWYxcHlxbzhmdWVXeTJhYXdDMEVSL0d6OVFDS1NEUlJ3a0YyTzF1WVBxamVW?=
 =?utf-8?B?ZTgwM0Z1MGdrMWgyTVN1M1labVl0NS93WFpuakxKYUJFa1FCckV1dHRqQml6?=
 =?utf-8?B?dmFkd0hmTWZ0QldyWTg5dmlTZ2VJT0o3WEhCQlBsS0RQbXVzU0ZMYzZSeW9s?=
 =?utf-8?B?QmlzREZGb0tOYit0RHZvNDJuS2FoeVhzcTZ5TGNzM3oxL2xBVTBQbHhsUEpV?=
 =?utf-8?B?RUY2ZEdjTVMwbytkOURPUHB5K3kwWlhoV1gyMXBCQjBJdXJLSy8wL3BRM0Qz?=
 =?utf-8?B?ZW9veVMvVkVLdkgwZ2JNc2d1cVBVNGtKeEt1b0hmbStZQUpPeUsyampxYkNC?=
 =?utf-8?B?Y2ZaZmxjVHRvQ21BYmJpNHU2MjdzQXlYQmtKOXZNb3BGRjJhb3RkbEVNN3Fl?=
 =?utf-8?B?Qjhob2tzWDRpSlNWRVVMZUlFSVBWdk9vUmI4Wjg1ZGI3M0FXNXRlL1NLZm95?=
 =?utf-8?B?WWIzTHdOVE9mL0NyZHRjN1RHTzBNVTBzcjBudTdjSFFMZFp5QzRqam9ManIx?=
 =?utf-8?B?d2tRTTNKaEJQblRrM1ZQSFF6RmdHQmdvdm83b1BFUXJtSnhNQ2cxU1E2ZkZV?=
 =?utf-8?B?Q3J1cFg3NFY4MnN3Q3FpWlZLZzVpWTFqZFdCZ25KSHZ4ZDJjdmdpR0VCL1J0?=
 =?utf-8?B?bjhHWGtYeWQ3YW01L1FzWUZkeUF0aFpZZHQySU1GQkN5T0IzL21GcC8rd093?=
 =?utf-8?B?dkV5NUtYR2hkaWh0WWJ5WlVrZUhEWkhTbWNOa2NwT3dUVUN6bnhDMTRYSmU4?=
 =?utf-8?B?dzA3V2JqN09qTDY5V3NIMmdBY09ZQW1rNzN1bWRGZS9TRW5pM1gxaGVKblhz?=
 =?utf-8?B?OCtUbnhmUS9vNFVuUmIvTDJFQVZ2TXp1dkRIMTdyYXlVaVZrTlZ1RS9uMVJX?=
 =?utf-8?B?Y1F0Ujdnd2EyNitXL0M1Y2czdnlOb2xkbXk4SmdaWWFwMkJJMmZnTkhhZ09y?=
 =?utf-8?B?U01vZ2VxODJIdEpsMkdvU1o5QTZjNXdZVTlPeERONElLeGxMVTBKS2RVZURQ?=
 =?utf-8?B?RTB0NENMTDBRVjE1VFA1OEk0a1ZzWklJclJ1U3JQbUFDYklnOEZVTDdSakFj?=
 =?utf-8?B?cXRNUDZCZHRuK0R1Z2FtUFNzVUdrMUJNYnplRVBrWU1nbmQxUDlrUjZScnlT?=
 =?utf-8?B?RXpSYWh5TzlEUVdlLzQ3U2k1WjRsOWkzZFZuc0NkVXROOFNKbzZVazQ5K0J5?=
 =?utf-8?B?SmxZZTNGa293ZVBXajVyeUVPTGVKdm1iOTJnNWNUT2dzL3hhY0JTNkoxTzN3?=
 =?utf-8?B?b1BQOFFtL3lENEIwY0Z6ejU2dDZJQU9Oazg0NDJ1MnNOTEFRSmxpbXBXQkFV?=
 =?utf-8?B?YXY3RVpGYnZmTVpYZS94Vmx1SXd5YzFPOGJzZ1k2RVlRbXdtRVIvdGlXMW9P?=
 =?utf-8?B?S1EzVjJya2FMZzlzL0dpZkpXZlY0cnVuekRpSGJnaEFHeUFPODNZa1hCMjlD?=
 =?utf-8?B?SzVaaUUyenB1eEhsYjlTNkdwTTAvTHF1aTdIUnZYNlpaRVFTWnUzaHFZY0dT?=
 =?utf-8?B?Y2ZkcDdzTGROb1dPT2o3Rm1oNll2UWZ2TE1MSkEwWXdtbWxXOE9GRzZxa1J4?=
 =?utf-8?B?aWNYTWFkQWFUaUpOa1psdkQ5cjAyVGZCZDNaeHNQeWdDMUhxa3dhdjNselNR?=
 =?utf-8?Q?flaJ2vo1RuOancYY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7972C9F595CBB4C93B2FDA833B5E502@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rP8+1+VnW7+W8o8fgjv+DTBllS0qMlPWWNXIgbVMGV8y+rL1sM7fl5d2CQnYHtS6SmvAa8e1GS34pGQMwacfuKiB1rjwUUxCklacLVtG4dM4lYHVV3LkerAruCWz5hu7L1YTtq7+Q6rfYV/A/vO2QSUfpWZTkk9ZSyM3eb4fjc9k4iYL1ialI04Ca3slo6KyCDC74Y046L/q6Wpu9Lc74NTNcfhN6zdvzzrPsGsQepLO7fmgrGQ1gIFMWwk0zQwp1WrYQ/FQYx20ELCQeGLv1Z+9UE5/nuBLgpttUOoYF2dEhwWBkPcc2/UVG1pF/MMA0nZrKszv1mMiaWkmlOR1+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50eee0c-b723-42ca-b73f-08def9950134
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 23:45:49.8718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+xKkKFt+sY9Kxn9vW8JXHBMKUVF8yq8pe0U0oB2uar7wzmRJwFpyo2Z+p68cs9argW7Vqf1dEZJP9Zy9iyVk1YRGfA4MjscOCsL/IuAp54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDIzOjEzICswMDAwLCBMaXNhIFdhbmcgd3JvdGU6DQo+ICtz
dGF0aWMgdm9pZCB0ZHhfY2hlY2tfYXR0cmlidXRlcyhzdHJ1Y3Qga3ZtX3ZtICp2bSwgdTY0IGF0
dHJpYnV0ZXMpDQo+ICt7DQo+ICsJc3RydWN0IGt2bV90ZHhfY2FwYWJpbGl0aWVzICp0ZHhfY2Fw
Ow0KPiArDQo+ICsJdGR4X2NhcCA9IHRkeF9yZWFkX2NhcGFiaWxpdGllcyh2bSk7DQo+ICsNCj4g
KwkvKiBNYWtlIHN1cmUgYWxsIHRoZSBhdHRyaWJ1dGVzIGFyZSByZXBvcnRlZCBhcyBzdXBwb3J0
ZWQgKi8NCj4gKwlURVNUX0FTU0VSVF9FUShhdHRyaWJ1dGVzICYgdGR4X2NhcC0+c3VwcG9ydGVk
X2F0dHJzLCBhdHRyaWJ1dGVzKTsNCg0KSSB0aGluayB0aGlzIHBhdGNoIGFjdHVhbGx5IGRvZXMg
bm90aGluZyBiZWNhdXNlIGF0dHJpYnV0ZXMgaXMgcGFzc2VkIGluIGFzIDA/DQpTbyAwICYgc3Vw
cG9ydGVkID09IDAuIEl0IGRvZXMgZXhlcmNpc2UgS1ZNX1REWF9DQVBBQklMSVRJRVMgYXMgY2xh
aW1lZCwgYnV0IHNvDQpkb2VzIHRkeF9maWx0ZXJfY3B1aWQoKS4gU28gZm9yIGEgbWluaW1hbCBz
dXBwb3J0LCB3ZSBjb3VsZCBwcm9iYWJseSBkcm9wIHRoaXMNCnBhdGNoLg0KDQo+ICt9DQo+ICsN
Cj4gwqB2b2lkIHRkeF9pbml0X3ZtKHN0cnVjdCBrdm1fdm0gKnZtLCB1NjQgYXR0cmlidXRlcykN
Cj4gwqB7DQo+IMKgCXN0cnVjdCBrdm1fdGR4X2luaXRfdm0gKmluaXRfdm07DQo+IEBAIC0xMTIs
NiArMTIyLDggQEAgdm9pZCB0ZHhfaW5pdF92bShzdHJ1Y3Qga3ZtX3ZtICp2bSwgdTY0IGF0dHJp
YnV0ZXMpDQo+IMKgCW1lbWNweSgmaW5pdF92bS0+Y3B1aWQsIGNwdWlkLCBrdm1fY3B1aWQyX3Np
emUoY3B1aWQtPm5lbnQpKTsNCj4gwqAJZnJlZShjcHVpZCk7DQo+IMKgDQo+ICsJdGR4X2NoZWNr
X2F0dHJpYnV0ZXModm0sIGF0dHJpYnV0ZXMpOw0KPiArDQo+IMKgCWluaXRfdm0tPmF0dHJpYnV0
ZXMgPSBhdHRyaWJ1dGVzOw0KPiDCoA0KPiDCoAl0ZHhfdm1faW9jdGwodm0sIEtWTV9URFhfSU5J
VF9WTSwgMCwgaW5pdF92bSk7DQoNCg==
