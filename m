Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A34457D8;
	Fri,  9 Oct 2026 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577148; cv=fail; b=JQoNPBWGZy7kdvV559knnNIohE7Uu49TWLYn6s+FjfylkEotNCSODSSR1J/3nZ6gKzHQgZbHTrgZG73U10tg+CjnaAr/h1wYw8seG3VAqoK2I42Jk7OVE6nKgeaUHp1P12h6JGwVDN+dAtbQgsrjoD7BUA5McD41wCd2GDWeMPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577148; c=relaxed/simple;
	bh=hDa+0K2jq+UWCz5lSzQa1wjJ5HTrI4gY96yFBD8XkQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VUmp5G2oQredAM8SFHBxMCY7z25HponVvxkoCYvennRMbu0w4cW57/y4kVtP+BO3XOZDTjxhxQAVKPfHWMps7KMQgbCV6cnnj7CNp1DxBmXggc4WIxyZmX6JGY5n9w7DXoCqWskQ1XTP9u/N4hdoxmTChvS5IeShrKQpMulRxS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4XEzRqc; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4XEzRqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791577148; x=1823113148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hDa+0K2jq+UWCz5lSzQa1wjJ5HTrI4gY96yFBD8XkQM=;
  b=i4XEzRqcY1VI9yTc5ZKFK6wAHiRv5WyIQNioAUNpIliF7nHKo/ZLUrtI
   bgmg0RrziXYCoHZZ+CU8O2ulJiKXpqeukR3cKDslh5t7/gGNRAcqTFKk5
   e/RKAlTbNR3njU+OZkMSbCMzE4wM6zJzUolDQ8ZMgyuLNEKwM0jHEb6XV
   3IYffwR/4797rTgPMn0NItmaJR42nxmPToKM6JmyRHSE4HtSKGUNJOkbp
   OI0vsOnisCjnRTGfIfLhHQOhzzo8/YgeM4g6szzV6vV/txaVv5eUKkvPB
   IvuFlXS/FiTiTE4FyIGdrTu4EXsav47Fv2lxbbC89cNADveaCKIbLkmaq
   A==;
X-CSE-ConnectionGUID: 7VriWgLSSGqYAq/Fa8tgIQ==
X-CSE-MsgGUID: MEIihyMIRN28+UADMl38iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="269563"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="269563"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:19:07 -0700
X-CSE-ConnectionGUID: 9VztC1X+SoGq325g+H153A==
X-CSE-MsgGUID: oFLcH8PJTiKVk4Ju2DOL3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2233674"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:19:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 13:19:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 13:19:05 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 13:19:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4rOr0JsbyP5WakWVPvz+972lOSnkliB3BEf8/vMCfRc3JnDdL8XrpOrDuCHshU4K3n3/9kthK986zP7yPGx+b+iTPgb9q8O8bBJ9qJ2y5GVKv8wbatgHsCJpXE5liFliH+AZ24G0S6mPJcKgvBSTTdnoe5om0D0V9wfzr5ZmGJ1YJ9MUbR0PywJZfTJIvSaPI0zZSUySaVjbSRR0n1VZTiKP3G53hz72KlfkNCHK9wYgYEl6e+ceZt5c4hwkKBThf/4fRgXYH3yHR6CXiwezpReuoREyPd3xgYC6IX0qb/DPUzQc2ckV2QTpH1skDpEZ60tA4/TT07I6X7FE5R/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDa+0K2jq+UWCz5lSzQa1wjJ5HTrI4gY96yFBD8XkQM=;
 b=mbKajf1mhUym+GYj7VI4bX108b+/LXeo4+fH+dVt/d3uziaQtvy9Erpp8U4yOidxXxKw2tOt6uvj4NPlsq3mm1fU4bHb2wdouzjXet3/yrbZ3lziL/fKFVL41X9FtaPg4gpJOXhmnRvUMTvlP9yD/8m5zrPrBFmghQQCLB+19MfjRVGQsaTpLODIMFnVW5ubRfboLegAHKZre+5xX2KE+rLLwRiDPeE2ogudu76iiyCxetufXcV3odquhNW92XuxVroXF84jqdMowvQMt68v7g6ldQJnnZU7bEqE/q63VbyB/cSc9OqwP9ObGwyhBBGrJl3t731mOs3txlIEhyIBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB7718.namprd11.prod.outlook.com (2603:10b6:510:2b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 9 Oct
 2026 20:18:53 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 20:18:52 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "rdunlap@infradead.org" <rdunlap@infradead.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] x86/early_printk: Add earlyprintk=tdx to drive the
 UART with TDVMCALLs
Thread-Topic: [PATCH v4 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Thread-Index: AQHdVRv1b/EtUaJ2xUyxkn5fSW90Urb1rJSA
Date: Fri, 9 Oct 2026 20:18:51 +0000
Message-ID: <8ea4594fea7247f3955fc2ce85cab42d3dc6e142.camel@intel.com>
References: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
	 <20261005-b4-tdx_earlyprintk_tdcalls-v4-2-3f7c56dd568a@intel.com>
In-Reply-To: <20261005-b4-tdx_earlyprintk_tdcalls-v4-2-3f7c56dd568a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB7718:EE_
x-ms-office365-filtering-correlation-id: 88346ce8-451e-48c7-131f-08df26428925
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|1800799024|366016|376014|10067099003|56012099006|6133799003|18002099003|3023799007|22082099003|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: xEaZ1OwK/nJVATLBJvnUiEzF5ph6ykSOkIhm8e9F8VwEMZ5VqtD+OMGUkztmbYqn8FubQ4r3Yg6WKt/GuUKTRAvXRLsws/DAwTSzpmkMy4P8OcpxffGcl3da+h4noVuBQRDIMKetD/48Bp5YaABSkI2n4VseckCmnUyjG0GRCi3vXGNiLFqZTjYWOeqASL8lGsCJ3EPSEYP40IMNIc0BJDwBV5aIIqIhkDaN+WRZwDA3iZzlfdO84IsMnzFtl/YpMtnzUUu9WpPKeSvVEPY/7KMB42cX0Lz1fnMnZmGsX46fyXQmH2iE99oMgMjKoPQbK7iyr7B5keQLuafrF7sVtir3vpi7UjZ4BYIVADIb1FpQg4WmFw/oC4JFSf4PYqohKGxDHWbcexZxfGMhbnjOHMbQEo6O9DICkq5D+9v6UVcNliwbkgkvTU26ovFU5pQM8CSD9MzpP5ZE9Nqot0quISb7xVsRNb7zGUCwbvfsL7XCXKpPqKvxuJXnTgTFeQxH5s412cqWQIcGUxqc3ChQmTSO2Jo04kl1YTh1XavlrsyNOvmUmi181cjJgu8HkOS94Lsjo6W+xz9Lc+uxJ/I7oFSlUbWj1X/4cBwnPO+TuB8J7MyeYF6q8v0pc54RfX9bLkSeM1YYLxk8C2I8lKPntJlS+buHVf3QnbqwE8lI/bUHJGujZZ6qZeNymut/fwkXNoCoqLKJDlcFfFJmvMic2s8azC7PHyjFTgtA5R2zk8c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(3023799007)(22082099003)(38070700021)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTFxcHQxcU9LNXk5VDA3SjUzWDB1RmZvOFRKZWU1YXdZZTdVQk80c2kyMnp1?=
 =?utf-8?B?WlJsaUlqaWh6dEdySSszYmpaZXdub2Fuci9kMjhXdldPODVPem1JNnJZOC80?=
 =?utf-8?B?UUlncm12LzU1dmZSbUMvVkpGc1E1OE5CVjh3ZkpVaXJrbVl0aXZHaXVEUDlO?=
 =?utf-8?B?ZkFmb1NVWXlickxvNzAyU2MvZ05tbURPc0xJUXB5a2pvb1ZoT2VIZTA3eFM3?=
 =?utf-8?B?M3plVVpBMURld1o2Q3JuUEVhd2JaMW9wZ3JrLzRvM2FsVEl6THFlVjRyYzNX?=
 =?utf-8?B?MXdTMXkzYlBkTkM5NjJxcm40cTZFVTgwRENJYkd0Vlp0Z3ZHUmdmMUFYRnhK?=
 =?utf-8?B?aGRKRGFESXNkSDdscmE5c3ZBNERUYlp6ZGV1WVJQVmEyOTBJNi9zOGdZRHA0?=
 =?utf-8?B?a3ZsQlpQTDNJTkcxMWhzQ3ZXbkFnbmtkMEpKNUZpOVlUQ29DQTE2bHZ5U1kx?=
 =?utf-8?B?bFg2WDBDWlBKYVBIWis5cDhCOTZmQ2RkYmQ4UUZvVTBlcFhUWG1iMkVtcDJV?=
 =?utf-8?B?Vmo0cUFPcWVvdmFWSHNaeXUzYmdpQklRTTQ2NS92VVdWRElSemUyRDlQOW05?=
 =?utf-8?B?VW00alhmSUdmQlBUbFZKZlhRSnRUQVVNQUNxeHFGMnJYRnNHa1loNVBqRVZa?=
 =?utf-8?B?dlJncUlwSVVTRDBhSDk2VnN1aGN6TmxhaFlGRkpXdVoveVpnUlZEREtQSWVE?=
 =?utf-8?B?WEJ5bEErWm5XSnp2eUpxVHkzMnRzb3ZBbXRTOWtkS2cxTTZXZDRiMnR0L3Vo?=
 =?utf-8?B?amZvTWRXYks1Y0ZvZ1IzcEE0STM5TUN1WXhyc3ZEOC9UaFRMWlFBRDM5RFUx?=
 =?utf-8?B?bS92cXc5MlFlbU0rcERwSkJ2ODVDbWJpVDBNUXpNYmVLUkZnTkVGQk8xcG5X?=
 =?utf-8?B?RWRMNk9ZbUdhZ1hweVlRMzR0ZXloM2VDTWR4bTNyRDN4dmQrYjhSOEcvUUdX?=
 =?utf-8?B?S1BQSDFaT0x1NitieXA0V3JxeTVLUmczRk1vbTNnakZWQ1RKaTI1OEZYM2RF?=
 =?utf-8?B?UFVCTmZsM1MzaUx5M3hFc3FOSEpRZ1lZTUlOMjdmL3NSRWNGOHlSYW1jS0lY?=
 =?utf-8?B?UUpZMDRla2pLZ2FOSXNqYmFCSUJBZEtHYlNvOFdBZmdGTnVlZ2NyUXJxNldR?=
 =?utf-8?B?ZFM2eVR4STVISXRJbkFCQkxIbHB0VFZ4SEZ2UkF5NWdZSUJuZnpBRE1hSlhF?=
 =?utf-8?B?enZCT2ZDLzltajBrTURYMVRUOVFTeWQ0NDBnd1FlWk00MjBrbmJjVExYaXg2?=
 =?utf-8?B?NzlpUVpwYjd2OElIdGF0QTZGYzZKZmUvVlNVSTQwZ1VxeGNvZUZnRGRkUTl3?=
 =?utf-8?B?ZnoxUDdYNnUxNkIwR1hOUFZjQkZjYnptenJWUkF5TVFiK0pCRXlnMEEva1R0?=
 =?utf-8?B?ZlVwdHJJbGdmZHpzRFFmSzBCRHlYRmNUTll2ZVE5S2k5bTZhUjFWZ2s3a2da?=
 =?utf-8?B?d1lRSDd3eWhTZGpiVDdtYm9aamRRQzVzQWlGbzZTOTVkZFZ2NFpxQmpkZ04z?=
 =?utf-8?B?UFlTK2RXdkF2eGQ3M1JaOTBGVEFyZnVOeWF5SHorc3dLaVhoazcrb3JLS3BS?=
 =?utf-8?B?Z0t2R0VGYlJlT01SZ2lraFZpZ3Q0eG9QM2hUSnVxWTc3a3N2ejRHVXBNemFB?=
 =?utf-8?B?R0hLeTRmTkFBOXROY2UvRHZVZ3FiWEQwbklIUFhRZ2kvVnJMV0dBUzExMFJO?=
 =?utf-8?B?NjNIMnhlNWs1dTRNVS9rQTJGQ29IWW10NitzWk9mZkU0UUxlckg0STE5V0xY?=
 =?utf-8?B?d01JeFYvMG5SMFFSRlRQTzhEWW5sM1lNK3Y3VHNuK0Y4RE43czR0T3N0bEtI?=
 =?utf-8?B?MjQ2dzZtZnFLM2YxL3RFNmxXMDFXaTU4NGJRL1c0d3krVEY4M2wwWXJFTGV4?=
 =?utf-8?B?UFA4cFZQa1puMExHVTh6a1d2NGl0SGVaTUhwRElSL3d3S3BUdTdRR3hwWlNt?=
 =?utf-8?B?YnhJYzJUdXl4cVRURVFkMkRMUFoxVk5icDFTSTBiQUFVc3ErRGNGMi9oTXNB?=
 =?utf-8?B?Q25sZWJsYmw0em1KMXJsM3FKSE9ZTWoxS2ZuZlRCL2VwN0dZMGxkRFV4RGtR?=
 =?utf-8?B?UjNYZUk1eUxQdHJkbnNDMG9BR2VBZjdkdy8rdThoc3J5dUs0dWQ3Uk9LS2gw?=
 =?utf-8?B?aG1IL0MyY0VvSy9XbE1qM0xHV01YZU5FQmdxbTJ5T3I2cmhIV2VKa2JzL1ZP?=
 =?utf-8?B?VWJkV3ZydlJIU1VCU0MwSkV3OWVkZS9mbmFMYjZ4dEJ5ZHBIMGkyWjdBMTNm?=
 =?utf-8?B?Z2h2WHg4THF0eEE1dExTa0VvV0RpY0tpd2VtZWE2SzZnYVlRcVFBSWk4eG1u?=
 =?utf-8?B?Skh6QXNTTm12ZER5SXVlcEVXNnNiK2pTRFVHVnFqcU5uNE5UdVZhVTVIN05u?=
 =?utf-8?Q?jhkmuoTWqnrGJq1M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76A29E12891CE140A07F7C8E00CFD3AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jkJEVLcET4oH0jJDNafFGeBZDz7NuF8yP1Z+1/60EhQjksv345x2ht2UBzrgyeON7vW1h1/GLhpXPeaihXGLtev0KvAiLvEenfTJdUmGJLc4JZOn8bzHSoh++WQHSgFHDeATL7g7Aw7oC8voi/+Uh4g58QLaHi59POGgs9JUeZjlpwdsd6YMeUMSeMSdNKqbDObvYgqJu3XBVqzeANlbdJg6gpPbxLChqSkQgISy9itqotLi2M56x8H1OusnltEA22ZHmjnA1U0MLSFvl3E1lFXLQAg+cF+DVExudKl5agLn3IEQbE3BUGDUTjK7OLoL890EtsacnKZ4zB8EJvKehA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88346ce8-451e-48c7-131f-08df26428925
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 20:18:52.0376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/mMJ5xFgy//WkbCa5raIJ5jN+BoAY8xUg6HGYOAVKpFrtqZnGRNE+f0yWSujCslwstsmoEJViUqB7Qq9Mivvrkst+wCRzRbf9pbQX3hMTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7718
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTEwLTA1IGF0IDE2OjUwIC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IEEgVERYIGd1ZXN0IGNhbm5vdCBleGVjdXRlIHBvcnQgSS9PIGluc3RydWN0aW9ucyBkaXJlY3Rs
eSwgYnV0DQo+IGVhcmx5cHJpbnRrJ3Mgc2VyaWFsIGNvbnNvbGUgc3RpbGwgaXNzdWVzIHBsYWlu
IGluYigpL291dGIoKSBhbmQgbGV0cw0KPiBlYWNoIG9uZSBmYXVsdCBpbnRvIHRoZSAjVkUgaGFu
ZGxlciB0byBiZSBlbXVsYXRlZCBhcyBhIFREVk1DQUxMLg0KPiANCj4gV2hpbGUgdGhhdCB3b3Jr
cywgaXQgaXMgYSByb3VuZGFib3V0IHdheSB0byBnZXQgYSBjaGFyYWN0ZXIgb3V0Lg0KPiBlYXJs
eV9zZXJpYWxfcHV0YygpIHBvbGxzIHRoZSBMU1IsIGFuZCB0aGVuIHdyaXRlcyBhIGJ5dGUsIGJ1
dCBzaW5jZSB0aGUNCj4gVERYIGd1ZXN0IGNhbid0IGRpcmVjdGx5IGRvIHBvcnQgSS9PLCBhICNW
RSBleGNlcHRpb24gaXMgcmFpc2VkLiBUaGUgI1ZFDQo+IGhhbmRsZXIgbXVzdCBjYWxsIFRERy5W
UC5WRUlORk8uR0VUIHRvIGZpbmQgb3V0IHdoYXQgZmF1bHRlZCwgYW5kIHRoZW4NCj4gaXQgY2Fu
IGlzc3VlIHRoZSBURFZNQ0FMTCB0aGF0IGRvZXMgdGhlIGFjdHVhbCB3b3JrLg0KPiANCj4gVGhp
cyBtYWtlcyAjVkUgYSBmdW5jdGlvbmFsIG1lY2hhbmlzbSBmb3IgZG9pbmcgSS9PLCB3aGljaCBp
cyBub3QNCj4gZGVzaXJhYmxlLCBpcyB1bm5lY2Vzc2FyaWx5IGNvbXBsaWNhdGVkIGFuZCBmcmFn
aWxlLCBhbmQgcmVzdWx0cyBpbg0KPiB0d2ljZSB0aGUgbnVtYmVyIG9mIGNhbGxzIGludG8gdGhl
IFREWCBtb2R1bGUuDQo+IA0KPiBJbnN0ZWFkLCBhZGQgYW4gZWFybHlwcmludGs9dGR4IG9wdGlv
biwgd2hpY2ggY2FuIGlzc3VlIHRoZSBURFZNQ0FMTHMNCj4gZGlyZWN0bHkuIEFkZCBhIHBhaXIg
b2YgdGR4X3NlcmlhbF9pbigpIGFuZCB0ZHhfc2VyaWFsX291dCgpIGFjY2Vzc29ycw0KPiBhbmQg
c2V0IHRoZW0gdXAgaW4gdGhpcyBjYXNlLg0KPiANCj4gTm90ZSB0aGF0IHRoZSBvdXRwdXQgZG9l
cyBub3QgYXBwZWFyIGFueSBlYXJsaWVyIC0gImVhcmx5cHJpbnRrPSIgaXMgYW4NCj4gZWFybHlf
cGFyYW0oKSwgc28gdGhlIGNvbnNvbGUgaXMgc3RpbGwgcmVnaXN0ZXJlZCBmcm9tDQo+IHBhcnNl
X2Vhcmx5X3BhcmFtKCkuIFRoaXMgb25seSBjaGFuZ2VzIGhvdyB0aGUgYnl0ZXMgbGVhdmUgdGhl
IGd1ZXN0DQo+IG9uY2UgaXQgaXMgdXAuDQo+IA0KPiBMTE1zIHdlcmUgdXNlZCB1bmRlciBzdXBl
cnZpc2lvbiB0byBjcmVhdGUgdGhpcyBwYXRjaCwgdG8gaGVscA0KPiB1bmRlcnN0YW5kIHRoZSBz
Y29wZSBhbmQgbWVjaGFuaXNtcywgY3JlYXRlIHRlc3RpbmcgaW5zdHJ1bWVudGF0aW9uDQo+ICh0
aHJvd2F3YXkpIHRvIGNvdW50ICNWRXMgaW4gdGhlIHNlcmlhbCB2cyB0ZHggZWFybHlwcmludGsg
c2V0dXBzLA0KPiBhbmQgdG8gZHJpdmUgbGFiIG1hY2hpbmVzIHRvIGRvIHRoaXMgdGVzdGluZy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwu
Y29tPg0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50
ZWwuY29tPg0K
