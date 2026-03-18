Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597632D73AD;
	Wed, 18 Mar 2026 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869805; cv=fail; b=L+J7qaP5XNgwGUOTgpsewSioAeiVlwbWtuomjOeVXGc9IHx70axgEXy+JLfudmRC1mUpX5XONm+pa1TZz7Bt919uC7E7SHDtRBf9zgNYJWMkadMmaP1QajQfMEj0Ofc0zTIVtglE2n0XoZMybi9ovv8rFJ6km8N6iKlXGx7C3Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869805; c=relaxed/simple;
	bh=dVx6kMUks2UlQzSePE5wSLsYx0arMnHYkkoIz6IlX6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PwPHT5JPJMhxJqW6DvhPP6dk+64yS7ajnQpP9c3qzCqAzIdtAdKUL3+QMcnmpi0PY9HDX+F7a6tnt0VKT6bS8UE184HVEMIwMpNtBFr6L9VaewBzySVTRV8TE/8XwcJ9yM3rmwc+GqGP0Sv0PiQLW3i2wehoQf/dfNTReIXxbyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/7Z3v3r; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/7Z3v3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773869803; x=1805405803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dVx6kMUks2UlQzSePE5wSLsYx0arMnHYkkoIz6IlX6A=;
  b=Q/7Z3v3rOkNYyLIjauvba5GY5Gkm5RpYnLsh1GTG2h5LyNZi5KERpnvU
   g125ja534pBjTBva0Qdo3oaEUnZqjQQi+RIMALyODAPHn3ZjERINUyvNS
   m7O0HCgVCmgcRYzVe+jGFejj1fPw8nqQmgI5DVB2Nim/ENvayz2wIGxHC
   dBxMrMhDDDxXEgCRP4YZS2rPpIkte7LaH0ETqryO/nZe5GhHTCSzNceJA
   dXeonW9x4f+JoYtoEh8i2oC02/yhXOsFNTNvEFhYaGrOu6lilHp7mlgK8
   6mOTSske9SClqe+oqfveCszsO6KpTiHvJZTfh73hCBOJly5N3eG8A5+VR
   g==;
X-CSE-ConnectionGUID: YsNf0NFpSLaOSVu0ZQxH3g==
X-CSE-MsgGUID: zj3jat/FTI2HlZA0dwidVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86296507"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="86296507"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:36:43 -0700
X-CSE-ConnectionGUID: w3KiHl5gTAC6ZyZ5nyay7Q==
X-CSE-MsgGUID: l4QOlpD3T+mfkIxy+KZhOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222805398"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:36:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 14:36:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 14:36:41 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 14:36:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QonWmLSH0umcWXM5y/vl6IhgdzowfAGp8yxyilwY3oh+7EXewGuZS9QJsercEtxV8U+ugIjVBCHHR6nFKlNsxJyRPDi2HW5R5+QQr5+ouSwMZlqU/cYfguhxXQ+o6gj8Et027gAQGiVuvyVaOqUYftTLOYtqOjqAtdnu9tfwU3FNm/fceG74NekM8FGDiLDfDJLtGVq2i7oH+6TNlbgROOoLcfbZT2IlVW+OykStewUhB/YjPuv4GHBWc28oCa5h05jTnQnptyqzYQF/6SmAh5ZtfvcHvAL80FcLTRSDuw+5ZdKltH7gExIkXuHqDklMxODUa3TlwbmeiUOcfKn2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVx6kMUks2UlQzSePE5wSLsYx0arMnHYkkoIz6IlX6A=;
 b=IJ1IdmqwsMPwnuBzmv9rtM1KGlyM76JQT8aFZ7Kh3EQHK6hSRDPvxXO3oeKtEDxCQk6ZUkz5PlGsf84A7d0IpI+PpUHvkTZYSEyE/jOfxZ03NGf2YLMqzR0xjWV1JN/0TXlBmqNDuJH1RF25FaevJUnMGi3RhahyWEszit6IiPovnQrb6RpNCQPA61B7qmN6OzwWJL5/dOtfvogClBeAvX9Jmenw48OqgF9R/sEsUCcJjPhP4BRxfVFOaIptwxHmyvpWff1oi6cIbhRqdnNmqVh+PdrniYDqkrTHTZiDhuorr0/0tyAbN+ZEZDmATn5cocDoebApEniyIA2J5BIfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Wed, 18 Mar 2026 21:36:30 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 21:36:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v5 08/22] x86/virt/seamldr: Allocate and populate a module
 update request
Thread-Topic: [PATCH v5 08/22] x86/virt/seamldr: Allocate and populate a
 module update request
Thread-Index: AQHctIP9deQWSScj4ESvAO7S/emtCrW01YMA
Date: Wed, 18 Mar 2026 21:36:29 +0000
Message-ID: <2932d9b1cb322343c895d565e7bd1b650edd740f.camel@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
	 <20260315135920.354657-9-chao.gao@intel.com>
In-Reply-To: <20260315135920.354657-9-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|BL3PR11MB6508:EE_
x-ms-office365-filtering-correlation-id: 6812ffc6-058c-477f-808c-08de85366a99
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 519FFCrDMrtuOQjIkOZ/QxQRDtFNVaHdCpdUs3YzYFGFawaRYcbR8ooaj1Ut8R3etPhLehMRTGzIH5dQWjyZaB4I5OGotedC9dnqQIMfevCyqan6941lH4r0OSMfPGqfF3ZeiPtCeEsAHdPutBX0TcWRW6MMHQs3seFSWqA0ZiX/78HFNP8tP3rAfadoO/FeWPHur8I8SPTrH7QtFVvlcEqYjG4L2r8+f2SwAL4Ev4XAGqmZoElhFMk6YYTH8/uuBCP3Jhey9w3spO/0MMADzVVCz7LLz/3i6bvxm51DdvVdJRymp6zMWj5gc1onN9sgkMat3flZEdlnQs22mhAnxz1qoNwhD+VOLbIrOxfPTcEmmMeoNpaxgvX6EzSDvn7IH9dBAKh88QNrR02euqWPDhFsOgLBjBQsws69sdBn+80FgPiURkoeKd0uJirYzob5h6Yh4t+dxUe7fyi7OXiVxM4CdWkUW/OyRjwgA7H49fFzCqNJxZviGvrB/5ffXgW0cWGltHCvV5l7c/EHdCMxoKz3kiTIQ0Qq5L93cvDRnegNyFeF70OjouhpxtgSHrewzw3rZubze654iZBXVpiy5PAoBBIuD8nta0d26dVnXAD9zUc89H7Q4Bg1jwqV0t75DXjaSEhhHgJDyvjaA1L6ASGWMRpqw4LUVa3fa+Lno+gHXXmYJoAHkekr3iN2aIwi1wrFnlDdADydjokPGmf2XkRrI1SwKFpSt+hrBnf5UfwV8ZD5Wg9gUzROxGthlYlA2JTQqMHrruDJOh0dzmKkbYPZk9Zue9Gr2MrmS+z2Nnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWlNM0x2VXUyRUhDVEhIbEkzdDJFNGVMOWxleVV2bTNsTnhHMHRYbFQ3YUZT?=
 =?utf-8?B?NnptZEovYzVvQVNlQTNtVVA1RXNTa1BZS1Rka0tKaURNVjRyakoycHpoSmJJ?=
 =?utf-8?B?aHNVREYxeWQwY0ExZHd2RU9TRjhFd243V1VLbGl2QzNYTCtob3o3L2ZXRERV?=
 =?utf-8?B?ZzVGRjJhQ2ZhN3NuQksrcnloQ1hmRzk1cGNhR0hvb0E0YVk0UHdLeHVVMVZa?=
 =?utf-8?B?NUl2VzR6NGpuNEV3Nm8wRFRtekxSYXI5T2ZZUDUrb3RGR2xwc0JBbzVEUURQ?=
 =?utf-8?B?aUQvUVVCK3VzZ2wvSFovSW1NWEZwdUt0Um9PVzB3VWtjWjQxcWU0V0pzd3pU?=
 =?utf-8?B?WGZDVDdBUUtDRU5lVVhETW5ZUU05dytPc0ZBNVRib2tlRURlamlQTzlseHhj?=
 =?utf-8?B?d0gzSklOdzU0ZWdzR3dhVk1XYW03MmFKd3FndjhzaXd5dnVnVGNxRm5GTlBS?=
 =?utf-8?B?Qm9XUSsvdzNLbXhDL01JdCt2NnBFdk1BenM0OTFmSyt5TVJhUUQ1TmJ4MlAy?=
 =?utf-8?B?aGw3YUNHM0hTaEtUQ0pwMkJjRHB1QnNVZkJFc0MwbzZpUkloY2ZCOExadGRC?=
 =?utf-8?B?VUxIWlFqdmZ2eTJHUHlSSy9UNGVzdjg3WGNBUlBuTzdENlpvcEpoU3luNkdT?=
 =?utf-8?B?YlkrU3F0Q1ZZNkREYXVHQkdYWlJkLzZLRktaUlZYWGZXSFcvNHRoZnU1RlZJ?=
 =?utf-8?B?cmtVbDBSL2JCNjFqS2RIbDdHQVQwc0lJY1BjZjRaNTNWY0s4YnA5RXJNU1N2?=
 =?utf-8?B?SnJQQjBzaW1lTFdMemp5WnRVZUhlSzRGc0Zxd1NEVFJrYnpaY3F2dHJ3LzRu?=
 =?utf-8?B?RjRKNEdhb2FEcTVheW9FOVZYQ0ZPZ3JZYXRpeFZkdUs3ekgwNUhEMmtxT1dr?=
 =?utf-8?B?UldUTjlHMEw0RFJxaUxQZlJxcmNpY3NNeVhkS0FpZllWODJtU29jZHA0UXZ4?=
 =?utf-8?B?aDlyemh2SkJQOGlyZVJUUDkwN0t0Ukd5Z1M2WWhIWk9HbWNZbHdyL2xiTVNY?=
 =?utf-8?B?cFhGMmNSQWNEOUxXODNHRmdpVmo0WTZXdkdoRVhhZ0JZNXMzNG9BNnhsZ2ZX?=
 =?utf-8?B?ZXhRdHpCVU12amY2WVlKRGQ0STRBSUpiMW5nYkx3c01xZlBkZmVzaitLY1Fk?=
 =?utf-8?B?K1gvNy9hWjYrQ00zT1pyS3hCajNJL09MNURDTVcxWHh4MWFLMzd6VjRNVWgw?=
 =?utf-8?B?V05COUJ3SEFkY2xWbUM4Vmk2a0hRYnV0N1d6Z0dVbU5jbUFFZkxEN2ZWSzdx?=
 =?utf-8?B?K1NKa2E3OG1NV0pMbUF2aHdKYmZlMGxnQUxrVlFjemh0RlZtOFFOWm90ek9n?=
 =?utf-8?B?U25Cc2pJV3YwMlo3dUNURWc2Y0I0cHUwTDVGOFVPdXQrTjFUUStjR2JFMHBr?=
 =?utf-8?B?ZUZCVDBIeFVvYjVaWWorQ3AzZCtCZjJRSW5uZ0RtU2ozcFBJQ3YwVjgvaFlT?=
 =?utf-8?B?aFFvSi83UVdFL2dIenpFWDhYT1JMYzNwaTdiT2RlM3RBZEZuck1CQVVmTVE2?=
 =?utf-8?B?NEowQVRtK3JNYVlLSmxjYXoreUJIQlFxR2VIMFFNQVdzRHkwNFR3UU5YK3I4?=
 =?utf-8?B?U3VCOUNXeDdyOVVFQmoyeFhyZEYwRkpCV1B0eDNTbmUrZnh6Ti85VjVqMWZn?=
 =?utf-8?B?akh2cGZJVTFRSEtDWGJuZ21NZ0NnWDVVK0doU2pMNmQ1VnplSFN5QVVnSmRv?=
 =?utf-8?B?NHRabFIvSnp5NE92REwrYmlteFJIdUxWd0J5UXdyRVY1K3FqQy9KL0hablVo?=
 =?utf-8?B?NjhGMzF2U0NFcTA0b2x6Y25DTXBxc213U2w1YVdEK0RxRjVwSWNMVzMzQVhy?=
 =?utf-8?B?MXhLTWJaeUVuQ2NXbkk0S1A3eFc5QVRDdnJNcHNGZTU5NzJnQ1hxYUFnT0Zm?=
 =?utf-8?B?VUpqRWt3amZmVEpCeGtnVElST1BxS3IwRDlXa090WWRGZ3ArN1U1dFY4ejll?=
 =?utf-8?B?Vmd3ZFdEdmdYZWVSSG1JSzc2NE1uMFQ0RG92eUtkK09tMEhjYzRONHFnbUpj?=
 =?utf-8?B?UE5GeEs3WTNoQmhwYzZYcUcxV1NsZHphRUZYRTBCcExXYlFIdGppOHIxKzVs?=
 =?utf-8?B?dDF6bmh5NC91L1NxT2tsaDJWZFI0T09yRkxpRXhBVlVXcEdEdDhjYWszcmdY?=
 =?utf-8?B?V0M3Vi9uN3o4Vmpyb3FQdWxtUXg1c1EzeEdMYUdjeUk0WEtsQ0NUYzVnNUIy?=
 =?utf-8?B?SWdoL1JpR1RYZ1pxcmtGcGlaTHU5b2VVZTB6Z2hSQW1hak51dXpCWjNEOWpx?=
 =?utf-8?B?OE0ydFltV0E4TXhONDhLRnVYeVozWHRBTkMxRVB0SDdnS0xCbXJmbFRFU2ZU?=
 =?utf-8?B?TXVGUmdUYVFPRytsOWRGR0V5bTFMQVgrQkdzTjIra0hUb1dhSnQzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D59EB5E46E796047810C07E0BC167D5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T/49DNleug5lQYqHjRupqqlUdm05Hpke/MCH9jp5MFxs1QGSY+W9dNG89eKkWMd2lxufI473YOJofiwNMN5fY+Thrg+Q1rtOcQvpX/bIie8nkJQAQgD8egVYw9X9vDrWEj+5or/n7KC/qLOVCj0JLX4AFbvs2EYQdGJKMGkqUIqRFJ/K/4KS+oUoFLtR3GrAftCkE0IJSUjtPvxxFpCe12Xc83u7bSiCfXU7bZtNZdTJiJZsgFxXCy0SmQ8rJ7HiY0puact0dfSsK6E6IrWuUBgLwojw3j42BLYN1pdbDzzRk2+WRLmLJ6RmPjVn9Ke71r9SN58638LVkAv7j5sZxg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6812ffc6-058c-477f-808c-08de85366a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 21:36:29.6122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTFpKswPEyU0WTqGQ6QhstN0SlLtsxNHIsNQ/bQu/6Oi9Ht0/sT4YdIy9HFOU+czlGP+TNpID0QE8/usHcUltg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTAzLTE1IGF0IDA2OjU4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gUC1T
RUFNTERSIHVzZXMgdGhlIFNFQU1MRFJfUEFSQU1TIHN0cnVjdHVyZSB0byBkZXNjcmliZSBURFgg
bW9kdWxlDQo+IHVwZGF0ZSByZXF1ZXN0cy4gVGhpcyBzdHJ1Y3R1cmUgY29udGFpbnMgcGh5c2lj
YWwgYWRkcmVzc2VzIHBvaW50aW5nIHRvDQo+IHRoZSBtb2R1bGUgYmluYXJ5IGFuZCBpdHMgc2ln
bmF0dXJlIGZpbGUgKG9yIHNpZ3N0cnVjdCksIGFsb25nIHdpdGggYW4NCj4gdXBkYXRlIHNjZW5h
cmlvIGZpZWxkLg0KPiANCj4gVERYIG1vZHVsZXMgYXJlIGRpc3RyaWJ1dGVkIGluIHRoZSB0ZHhf
YmxvYiBmb3JtYXQgZGVmaW5lZCBpbg0KPiBibG9iX3N0cnVjdHVyZS50eHQgZnJvbSB0aGUgIklu
dGVsIFREWCBtb2R1bGUgQmluYXJpZXMgUmVwb3NpdG9yeSIuIEENCj4gdGR4X2Jsb2IgY29udGFp
bnMgYSBoZWFkZXIsIHNpZ3N0cnVjdCwgYW5kIG1vZHVsZSBiaW5hcnkuIFRoaXMgaXMgYWxzbyB0
aGUNCj4gZm9ybWF0IHN1cHBsaWVkIGJ5IHRoZSB1c2Vyc3BhY2UgdG8gdGhlIGtlcm5lbC4NCj4g
DQo+IFBhcnNlIHRoZSB0ZHhfYmxvYiBmb3JtYXQgYW5kIHBvcHVsYXRlIGEgU0VBTUxEUl9QQVJB
TVMgc3RydWN0dXJlDQo+IGFjY29yZGluZ2x5LiBUaGlzIHN0cnVjdHVyZSB3aWxsIGJlIHBhc3Nl
ZCB0byBQLVNFQU1MRFIgdG8gaW5pdGlhdGUgdGhlDQo+IHVwZGF0ZS4NCj4gDQo+IE5vdGUgdGhh
dCB0aGUgc2lnc3RydWN0X3BhIGZpZWxkIGluIFNFQU1MRFJfUEFSQU1TIGhhcyBiZWVuIGV4dGVu
ZGVkIHRvDQo+IGEgNC1lbGVtZW50IGFycmF5LiBUaGUgdXBkYXRlZCAiU0VBTSBMb2FkZXIgKFNF
QU1MRFIpIEludGVyZmFjZQ0KPiBTcGVjaWZpY2F0aW9uIiB3aWxsIGJlIHB1Ymxpc2hlZCBzZXBh
cmF0ZWx5LiBQLVNFQU1MRFIgY29tcGF0aWJpbGl0eQ0KPiB2YWxpZGF0aW9uIChzdWNoIGFzIDRL
QiB2cyAxNktCIHNpZ3N0cnVjdCBzdXBwb3J0KSBpcyBsZWZ0IHRvIHVzZXJzcGFjZSwNCj4gd2hp
Y2ggbXVzdCB2ZXJpZnkgdGhlIFAtU0VBTUxEUiB2ZXJzaW9uIG1lZXRzIHRoZSBURFggbW9kdWxl
J3MgbWluaW11bQ0KPiByZXF1aXJlbWVudHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEdh
byA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9u
eS5saW5kZ3JlbkBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBYdSBZaWx1biA8eWls
dW4ueHVAbGludXguaW50ZWwuY29tPg0KPiANCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2Fp
Lmh1YW5nQGludGVsLmNvbT4NCg==
