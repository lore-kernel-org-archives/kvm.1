Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B913E559E;
	Tue, 31 Mar 2026 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975078; cv=fail; b=inyjrHSiOWdFaTr7caXZo0rd+LSMCpuDg5H184fw4rRDrisBCR5aG+/QmMabFK3eV7jUNQ9oLg5hsXMCqPnYtklolbYTMb+s2vKLEQ8h1oz3napdY3xBpTOCoGykdscRAyPQTn58YMwIImC+Fl9xz40HG77TWuFt2hMDeVEuDAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975078; c=relaxed/simple;
	bh=WEaFMn8aQ9XkVy1WRQ5C/IIkTonB17UEGqbKxJiXTEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EDEnrC7lGDhQkIh33Jg3Fe9ajljEhyJ2HflpIkEqyEP0texYkBR+fH4SqcJV1f2X4c1aPqR7eHocoQe1quUpSHg43GTsaenqZsZlQry7bWJu/Yp/4IT1Jqx9miq5qIM6meLyJhUb94H13v0ma7HYJ0CLAPXeDKb5crNtCVzOT0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1gqxTGR; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1gqxTGR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774975077; x=1806511077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WEaFMn8aQ9XkVy1WRQ5C/IIkTonB17UEGqbKxJiXTEA=;
  b=f1gqxTGRjoYH8GDVmuqhCNSKKFV7rG1xznOu/3IjUylf7xxkA3CfZu8P
   7CZpqpCjnN7CXN7W5TaNa6Lbx7D32ltIk7mIO6vtqs+xniRQsKx6qh/+q
   vqF6hhjgZhv+pX0xMahuVK/tYCDDiTD+8Am5UkkU32KYQ6iy3Mjf8Kqbp
   vM2XHBBVLpTy2+jciombjGx6S0w5v/Q+6d1N2ApHvNl2sRQ8GSt0FR4WG
   UcBsfo3H+h1kSBB6sEVjWfjWbTtfu1vuSmF9eEFq9ByodLEj+AHKiHtQ4
   neBF6mVqPjsxL3rONQUDTlJJbbFlLceeTpo6Jw8yiUfgYd8AV+z/42iUk
   g==;
X-CSE-ConnectionGUID: pKdouzbnSrSdlVLT+kbGWQ==
X-CSE-MsgGUID: b7tTkXvPTBiCj+U9dO88fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86692158"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86692158"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 09:37:56 -0700
X-CSE-ConnectionGUID: MGGeg4HTQm+xLbGHNt4DWA==
X-CSE-MsgGUID: UMN//adSRQutqs/l+J/N7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="256913275"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 09:37:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 09:37:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 09:37:55 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 09:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3v6Ru0oix3+g8CwnpYjYij3QMlTZNmEfAFwd9Qd47Ftu6YMkHWfdFzOHcixtgMV1ZU8yxnuR6n46kzpkt8cdltYYXITv9IbPSC6GPdU3Ioy//ZVNjZZbMg+on1eNP580Kog8fnslA9RQLxQCFAHWV2rJRcKMGO4HgROdn91lYBbm7JGobnK2+ESlLe+0BsjBaeBr4eb/HuwqcGDwRXXj7hCsd0p1DE5aGwjPMkYWydrfEBMjKqH4O3ZxARDjpuTroiF+h57y25uIp4lT4w2fTq9QQnWs91MxpYwZsyXEqHp4xeUOdZRqwUWjU8wAvryLCLDKvHbOjG3wpfzatvLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEaFMn8aQ9XkVy1WRQ5C/IIkTonB17UEGqbKxJiXTEA=;
 b=Nvn+yol652x7zTg0XFb6zeGQgdyFC5A4XtOUoiXscD8UHx8fFp14ttI+YwhBO3n8ehfD5/IGlHNVoSTy7Hy6OtmAmdz3oeAbr+JfbobrCYe4K1OTE6/jpoNJyi/y31j+/dLcepMB/Tee+1+JoBTsKsreX1wR2vAhO0vKwMFWjW6+ZGjI0CJwTznxK7AX5gVYxTKZ8n8g2xN3ROfFkTiXJhXMl9w2tiO2ffec86q++y60GjoNZD5dyDIWNmxtQO17qHzVvePC14n3KKiyZh37I/07YAX26N5OZ+Wju++4djQvAjWjwQuFEs6jkenKpnTS54NZGGErx1+l0wJ57M9JOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by CO1PR11MB4996.namprd11.prod.outlook.com (2603:10b6:303:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 16:37:51 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::893d:78de:7a85:7c8c]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::893d:78de:7a85:7c8c%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 16:37:51 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 06/17] KVM: x86/tdp_mmu: Morph the !is_frozen_spte() check
 into a KVM_MMU_WARN_ON()
Thread-Topic: [PATCH 06/17] KVM: x86/tdp_mmu: Morph the !is_frozen_spte()
 check into a KVM_MMU_WARN_ON()
Thread-Index: AQHcviZbfW3eiMcXjU2SG/Vbg5XdxbXGiBMAgAJVkAA=
Date: Tue, 31 Mar 2026 16:37:51 +0000
Message-ID: <3a046909b0e295d810ab9a7bf6a35980a9c708ab.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-7-rick.p.edgecombe@intel.com>
	 <acoDhjbA0xIycCJH@yzhao56-desk.sh.intel.com>
In-Reply-To: <acoDhjbA0xIycCJH@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|CO1PR11MB4996:EE_
x-ms-office365-filtering-correlation-id: 2e90d554-7c37-4b45-2481-08de8f43d9c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: sAB5zcqKxKqbJRoQpQ6NrnepbIYQ6ZO8CCDpNxGXUPvZ9XrZFB3mUZ2sylYSHo9hL1PtBa4dwfDNn0kJlrLMTO+iS1EH6fOmSGmA6Q7GX1EEjllsvj5Z99R93eercrkAe4XW6pJ8VlOV9zIH18hCAHNhFcb8fwBNLk2DVJbBkb4LDUe/ymTLKnq76Qnq0CKYB9N2x24c9kOATT1iigemA8GpkB45XCj9v+SLF+wVgMwMEWI4xFMFZb+QNK7P/GMtaaT0P6n7q5JSuabjk0Ka/6D5siwQFatcUK6E1XzAtc/mZ3f42UXI3RG2Y3WBtBE2yQBS+vSXmiHiRgaXHetERh0BkpLnPqMoUJXlOQRnDguRIhIzdAZNvcd0T38H27PmnJ11juLaviVkldc5mDEAmOiTjZCyZDWKH19YivVFNkbQUWqOgJl5AyG/bgPrrFxVngv1dMXPd16Jff5nd+yCYPr4GaqCWJOcyXP+wYGCQBogsmb6VQ2Fv3ZPqRtwjZwHuIMT/COdc1glY2nv7yCzLyKUzblMTtQwxePBmLKCJESQT2+H1SHYhRNEb94/h6Z4dU5y3K1rQl4y7Z14lRb5DT2hmgt8FFMGAvGi0gZVhtO5DwurCHm8+FQ7r2bCrlj6nUH++p0L0HXoim726ph+jvE4Yto5+0qyR7by/CL33yH/55FI4uepeZY9phKQHf5Ae5+Y+7TZp88f3v+zEVSpamaPufvcGFbwfPXbFtVFchJ0ihzGg1HXtcuveABsBiyNBKq0qmKxjGeX/0hBL6gv7qNsSv6/okBh8sLMvsW7W08=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3Rhem9xMUFkUkpEMzhtVldCbXA3Q0V1U3lRakM0MmR2U1QvQ3owV1czVEcy?=
 =?utf-8?B?VFljZnQ5SE82RkZGTzFYNldkaUxiTGswd0RlZHhjRTdjbld1dTlHTlJPUUhF?=
 =?utf-8?B?T2hzZUhXRTZnN1RiZW9vYndpQVRNbVhFRnBZRmpISUZlYjFKUTlzbXA2Mld4?=
 =?utf-8?B?MWN2Zm4yV0hIYUJwUnhtRWlpclNSZUl6eUk2d1hUeFUwUW9ya2JnV3Ryc01Z?=
 =?utf-8?B?bmFOSjIrd0t6MkEyV2RsSEw2OVhFNVlZbHpUM080SDhQWFNlQ0xlbTZ0Uk9T?=
 =?utf-8?B?cXZUZjRuN3JSQkQ1VUQ5a0doeVlTTnhNbXNqYVBObHZFZTdkeUxMNnVIcG9K?=
 =?utf-8?B?RXZVQVpCNS9GT1RmLzlqUVZpbjE2U2wxUnE0dFBOa0FZSGhWckJodHRhRGxp?=
 =?utf-8?B?eHNkSzlIOTNveVhGQXBVV2ZuTHZ5RjlhR2h0bnJJd2RPT05OWXY1SGNSM25o?=
 =?utf-8?B?UUdCT0ROQWN6RG50YXF0SGY1ZmdDZDVWd0kvRHlzMFY5NnRhWHpKd1VmTnc5?=
 =?utf-8?B?TDFyaW96b0poRDdmMUNIU0ZzYmw2TlNJU3dOY0NEaTU5SklDcjdQZ1dYZDdv?=
 =?utf-8?B?Y3NCQ0xhVXhlcWE2SzZVRU1nUEo4WUtwZFREdG1GaDd6UjZEWm9SdG5zNy8w?=
 =?utf-8?B?UDBhLzBqeXJYd1BoWHlDT2k1dWg5NlFMd1owVEYzNDlmVHg5aHIvVkFHSnl4?=
 =?utf-8?B?VG40Rm94SnVnV21ONS9TZ0xOdysyQzlJZ3lhMlYzc3huN0hTZmVJZU90REJV?=
 =?utf-8?B?MUhBdndCVDgzdSs5a2VQY2NQVkxRTFZmWHd1ZEN6NEJmb0ZCUlZtckNvdEdQ?=
 =?utf-8?B?aEJBZ3ZyQm51N2t0Q1BRRWozVC9OdnNNQVBuQU1SS3B3cDdOeFgzb3VHZ05t?=
 =?utf-8?B?VmZobksvWUxrOGxIZG9EZEZtUXJrMkQrelVSRHBNalpvbllZTHp6N2ZaQXVt?=
 =?utf-8?B?bDJ5aTdTVkJFaFUvRHpTOFIvcWloRVdqTGF6a0I0cWJucXNlVGp0M3FNM0J0?=
 =?utf-8?B?NWw2U2FvM1VySVQvMktaQ0wvbTVZVUpPQUJ3RDVTaVFVc1VqZDl6UElZVDNa?=
 =?utf-8?B?cXpIOEFUbU5kNC9CYWt0T01HM24wdFJ0MU5IejVSRkJHMkRzdUZYQlF0ams3?=
 =?utf-8?B?YzlpS0hHczhWMmpYSmxKWFVWbnl1QXhJWXlvd0JVaEc2bUVuUElCN09oVEVh?=
 =?utf-8?B?L1M1M3lqeEk1UW0vV1AzNlNBMHBGdXBYVTZUUlRLL0ttVzBsR3U5MXZOUktr?=
 =?utf-8?B?ZHdkbHpXWUFuVmVYb1llMlRGcHJaUVRNSFpiWXVnTzBJZDlMckhLVXJSN2hk?=
 =?utf-8?B?dTVESEtOME5GY1p1UVd5UEZncTUvUk9XbFByS0lENllJTlRhOU0ydGxydmdy?=
 =?utf-8?B?ZEZZQjJUdVl4cTh3WEFHT2tQUlJuWk9FOWxvam1TdXJ6a2dHNjlkZXJhZVBi?=
 =?utf-8?B?RUxTblE3Wk5ESGZ2enovRGJWVGwzb0hQejQyRFBUdmZLVk5MN0F1VEMwT29N?=
 =?utf-8?B?bUk5WUd4KzFiMkFmRzhzYUVUeGY0dU1hdmF0Q2Q5M1RXOU94RnZXSjF0TzJ3?=
 =?utf-8?B?K1JkdVhjNWhHSlN0V0pqdlN2K3lNSG82ZndodmtFSWJFNklxRkdCZWgvZUNN?=
 =?utf-8?B?VVZSNWhUcll5TmphU1VEaW9KUGpHTzV4Rk9XcWtLaW1xTHQ4TVBrMEdoVVBp?=
 =?utf-8?B?ZXJIZHpPbjdwUjl4UE9UUkxOdGZKckZnM3gzMkVadkRZOFBMTk9rQVhaNk00?=
 =?utf-8?B?YVNIS2FJRDFrNG5UejNWaTBZTjIzS0dRdys4OFVnSk44TnN2czdDMFFkZVVM?=
 =?utf-8?B?Vm9hTU9BOGx0b0YvNEV6NW5IZkRtT1VRTG0vNFFGQVZXWTFDajcyTzFKNWMy?=
 =?utf-8?B?aGNHVitGZHU3dXplKzZSNmZCSEdKODlIK0R3Qm1iNnh2T05LMUdCRGZZVFE0?=
 =?utf-8?B?Vk5mYzNXSXJXYWhXYUx3a3AwNnNTN1FwS2J5dTVzdnJOOC8yZVZxMERod0tq?=
 =?utf-8?B?dmU4SDNYTWFhd080MTg2YkRLRjRHZ2RUVHphbVoxQ0Z3QkpmVzMxdGpVVXVT?=
 =?utf-8?B?RFZ6UTlJdHMwSldFYWcydjc2WGdOaGNYR3hsd0hhMmM4eG1meVlPY2UrTExQ?=
 =?utf-8?B?N2VOUFcwY1hkYy91bSsxK3hNSWpkekQ0cmV4cU5mck1USXhnc2JFZTFYN280?=
 =?utf-8?B?OThEOHhHRVhTY09OaXRnY21GZ0ZHYlRJUkxwUFpWaVR1MU5tZDZlMktWdkwx?=
 =?utf-8?B?SGUrSEZ3bWIyN1VyTkFFNWNRbWJFMjgyNjVUdjVCRGNCV0sxUUpTdVQ1UllR?=
 =?utf-8?B?cjlrZFUxdHVhUk1EYkk1ZG03WUFWLzgwK2U3VHJUTHF6QWtBUGNHaFdWN2FS?=
 =?utf-8?Q?U15dnU7qxjlPc1Og=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A9A4A2E811C62468B2994EC388D26A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tjg88jCOWEHLXbcieebvDaziy5DMrP0SWmWo3Qr/DjxhVjUo6soCwHiTqcbg/agqhSbNFOzXvZdQp1iRRk/va5YZDCE4o/4RajEgb1qZzFIWSFIARVFyvLtUPzKoG4ceFjS5qJzwdR4o+ee+Hlsd4dJjiu+iyg8ngbI4dp0naj0gxp5fwk6e9RwzEK4uUcztu93nXignVc9oKaP0RecJjCeWruLCu9X6wFHpYrWh9hA8etn3piP9DT+SDcGe6QfvvP98NU0OjYAMCwbDOtRWqGJBmxC6hY0ojMIyngwjeFRNEs3IRcAlcootnfnaBYc5kY8rVweDj6aiW8Tkgym5pw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e90d554-7c37-4b45-2481-08de8f43d9c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 16:37:51.1651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZmWVOEEzn9zgD5eltJKIxhWMzH/yPN+6+DCzI3kfrmszpIQ06zEWAUhFkFIxBmXBz+kQHUO6kPKoO5oA7w1BbX8O9apceRYDGy7mG/WWLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4996
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDEzOjAwICswODAwLCBZYW4gWmhhbyB3cm90ZToNCg0KWWVw
IG9uIHRoZSB0eXBvcy4gDQoNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rdm0vbW11L3RkcF9tbXUuYw0K
PiA+ICsrKyBiL2FyY2gveDg2L2t2bS9tbXUvdGRwX21tdS5jDQo+ID4gQEAgLTY1Niw3ICs2NTYs
MTMgQEAgc3RhdGljIGlubGluZSBpbnQgX19tdXN0X2NoZWNrDQo+ID4gX190ZHBfbW11X3NldF9z
cHRlX2F0b21pYyhzdHJ1Y3Qga3ZtICprdm0sDQo+ID4gwqDCoAkgKi8NCj4gPiDCoMKgCVdBUk5f
T05fT05DRShpdGVyLT55aWVsZGVkIHx8IGlzX2Zyb3plbl9zcHRlKGl0ZXItDQo+ID4gPm9sZF9z
cHRlKSk7DQo+ID4gwqAgDQo+ID4gLQlpZiAoaXNfbWlycm9yX3NwdGVwKGl0ZXItPnNwdGVwKSAm
Jg0KPiA+ICFpc19mcm96ZW5fc3B0ZShuZXdfc3B0ZSkpIHsNCj4gPiArCS8qDQo+ID4gKwkgKiBG
Uk9aRU5fU1BURSBpcyBhIHRlbXBvcmFyeSBzdGF0ZSBhbmQgc2hvdWxkIG5ldmVyIGJlDQo+ID4g
c2V0IHZpYSBoaWdoZXINCj4gPiArCSAqIGxldmVsIGhlbHBlcnMuDQo+ID4gKwkgKi8NCj4gPiAr
CUtWTV9NTVVfV0FSTl9PTihpc19mcm96ZW5fc3B0ZShuZXdfc3B0ZSkpOw0KPiBXaHkgaXMgS1ZN
X01NVV9XQVJOX09OKCkgdXNlZCBoZXJlIGZvciBuZXdfc3B0ZSB3aGlsZSBXQVJOX09OX09OQ0Uo
KQ0KPiBpcyB1c2VkDQo+IGFib3ZlIGZvciBvbGRfc3B0ZT8NCg0KRm9yIHRoZSBLVk1fTU1VX1dB
Uk5fT04oKSBpdCB3YXMgU2VhbidzIHN1Z2dlc3Rpb24uDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvYVlZbjBuZjJjYXlZdThlN0Bnb29nbGUuY29tLw0KDQpJdCBhbGxvd3MgZm9yIGNv
bXBpbGluZyBpdCBvdXQsIHNvIHByb2JhYmx5IGEgYmV0dGVyIGNob2ljZS4gU28gSSBzZWUNCnRo
ZSBvcHRpb25zIGFyZSBsZWF2ZSB0aGVtIGRpZmZlcmVudCBvciBvcHBvcnR1bmlzdGljYWxseSBj
b252ZXJ0IHRoZQ0Kb3RoZXIgb25lIHRvIEtWTV9NTVVfV0FSTl9PTigpLiBUaG91Z2h0cz8NCg==
