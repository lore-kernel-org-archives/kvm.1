Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28E49E14E;
	Mon, 12 Oct 2026 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820295; cv=fail; b=S0deCSwlpNopedUmlUtlQf82beterR4SW80b8+brqCGb8oNy+fsRID1ATuyDUl0hmjGdWkr71iUZMfoZ4wCxOoubHJBd9KRxJG4+dGQ7x/OhZAC/bdlmlaC0MCa8XtAhci2MWkUgQ/Srg2Me62jdih0WknL94Dt0LIIXDLKG4r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820295; c=relaxed/simple;
	bh=kDBC+e+C/brd+WeuTF6cKwlGTKinQLrs6ZlQQ9v+cFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i6cR0b5rpHrqLNWpdbRjEdXF3SE6wP9SXjCgZFc6t2ckNNtzNLjjuNI2cz1mDTMoK+a/xVZ7mUn1MSNT8TZ35MOFIVz9SxqULD92SlAMSuzMWKczXWYAR316kfyhyZ2iRENJX5X/cIG47D32Q1Uh8J+LVsx8hICT3ei2JGP+t1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TugKhSEz; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TugKhSEz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791820294; x=1823356294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kDBC+e+C/brd+WeuTF6cKwlGTKinQLrs6ZlQQ9v+cFc=;
  b=TugKhSEzWQBa0MtJffJtDft52O9dCN/SELPnWIORm23siX81sP4s8Txz
   w7qnoQqQaUESaH7KFjggj7NAwfjfiMYfWmY+4heyOxy42RQ56BDXhoeG5
   TPH5Bxr9+pSOJtNeN0kNowMdG+eb6UWRcK0XZ7RAPQbvk9gJ+Coom2wz3
   3tuIOaFJ9brUncCiiVsPT2M+4ilCLtxPpM1nOrlaln2fiwfa1yCmM9e+T
   qdLwaR7jYKec3uWBUWQcnR29RuH5nMh8ICGRSrtvhrjYB+Qp+836+w7ye
   ieEJbzNzprAokD5A0GQhbRf5rhOjjqiffZ9AaovQGVvc7iMm3sv2L0VXP
   Q==;
X-CSE-ConnectionGUID: pmd8MN/OQwmtviBw2DjKxg==
X-CSE-MsgGUID: CPbKagFhSP+9KyiHFwxFqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="537355"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="537355"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 08:51:33 -0700
X-CSE-ConnectionGUID: GK/cHOJMQVOCerfSU5VuWQ==
X-CSE-MsgGUID: dE/CRjj6TNiXLCP/fpN/Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1015509"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 08:51:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 08:51:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 08:51:32 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 08:51:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/51mjT+1RB1fTN25WrUfy3RonJ/YHkoyYuc867W1rzSCD5dfOWZMYKCUydvIJ6IlMw5Ftj6HNgJOstKDIW4SpNvotg8n6+kWYqItYDg6XN/B0J4NibykH1cN9ILX8BqaKP2trw4YYSnyGzSvlZeLvcdKw1uwTE/nLHKl0GnfDpr2N9YgwwCa7VEOr9GWuP+pA8D9Hjqv2Y9qPtCsoG+Tdjkowr1HKEP/S/JctKoCBJ3i29H0IukLktv2AVM9DufC8R4KOrxuxYIUBl6QU+osl5pXPsp0cL1rAWP0Fbt73iCR5+ICm21pFUF+NGjIeBCrwZ0dT9j/IQPKH8YiTEUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDBC+e+C/brd+WeuTF6cKwlGTKinQLrs6ZlQQ9v+cFc=;
 b=PbkSlMXi+EQDYJ5zZUNt6xSSyGMgghoqvulHgYXiOnGQ4pLOAZxvIbNFTQvpcMLtoMwRqKM6X5CHbgjoMFMYUMg9GpWR5uFbQ5QBijSceoBjQ+IShtswTfu3JKcDGmvjEqs9awCcwUo4/ipVEiIlIKmzNZpBZmHTgXJW9pAIrelcZS4K5i/zEfz3Ub4FaaLcPDHcMTp2ogl1GbNIRnis9a+jK+Ce0QoT4LS/4rV2qilS6DSh/tWB6Oopj8U8nf40CH9YPSh+qAQ2FXeYJ3VeUNiv1SRSGCT68aez7uDuB/1aYsMBkL+1U59zI93VuKgnwibG61ZiaPG69GdOvJq0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH0PR11MB7495.namprd11.prod.outlook.com (2603:10b6:510:289::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 15:51:21 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 15:51:21 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "isaku.yamahata@intel.com"
	<isaku.yamahata@intel.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "pratikrajesh.sampat@amd.com"
	<pratikrajesh.sampat@amd.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"oupton@kernel.org" <oupton@kernel.org>, "wyihan@google.com"
	<wyihan@google.com>, "sagis@google.com" <sagis@google.com>, "Gao, Chao"
	<chao.gao@intel.com>, "Wang, Roger" <runanwang@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "chenyi.qiang@intel.com"
	<chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 00/22] TDX KVM selftests
Thread-Topic: [PATCH v14 00/22] TDX KVM selftests
Thread-Index: AQHdGi/fD3HeSKoX5UGSIW2nqtNBd7actxyAgAAE64CABQ68gIAA5NqAgFHwfICAAdjLAIAEFcyA
Date: Mon, 12 Oct 2026 15:51:21 +0000
Message-ID: <f2c4b662dd1a97fc183751d869e320646dac2115.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
	 <5a44a6925715e1edbd379ac0ea5526ec990eb819.camel@intel.com>
	 <4828f8e29801adb29a4d48b8980d3b3a0a813e06.camel@intel.com>
	 <CAEvNRgELDhXvPFKaoz+w-yywoJn0WMWvA-Y2jfdnwJVSbCSWyw@mail.gmail.com>
	 <0782a971b1e6aa64c12ba76f9a4e68c8fe72bd2c.camel@intel.com>
	 <b2a03539707ee8155f277a7c9f3e505de8978c0b.camel@intel.com>
	 <1fd70147-e175-43e4-b7a5-468d557ceb0c@intel.com>
In-Reply-To: <1fd70147-e175-43e4-b7a5-468d557ceb0c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH0PR11MB7495:EE_
x-ms-office365-filtering-correlation-id: 61c40648-f42c-4017-94d1-08df2878a964
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|261009223027099003|11063799006|38070700021|56012099006|4143699003|10067099003|22082099003|18002099003|921020;
x-microsoft-antispam-message-info: 7vhSFJJbv/9j9ecpTpRCIP9Vc0CyWdBipJcZfISZaIQaxFhYrqd+OrVq0EI9HcB/kQemFTQtVkEtF6JQ7YaUJiw2l+FZLKifVbjbHMGjIOMTx/SPZm7HnT7olX+UqTyuTXHU6IOcLnlMm9L0/v1rmEgSC7eE5wbCF24iRrKD5lhkHC41oF6fJwaH2iWgJOao1jvfvRPkD3/9ZT30lxatQAqiVhltCL9R7A0G+dIDr1nB5pJjeO31z7pDxK5ugLkBxNlI0b5+0NpLSdiZbvys1PUDDVj1e2oaWkfKu9+jQ2oRiVHJ+VNKcqDWbISl2xhsEKsf3eXPPnaddr1mGsRSWPY6NpTG8EpwDR6KXBbLrq6arJ5SVomEQ8kF75ir9OXrl2g2Ylaz/5A656sHt7KT8lTxBVEY9mssj083gMZpoAdo0TIZzVfxPQPhaZud/NkYoSyPw3v+e8C7hWAoYTat5RJVydboq5W2bgq0vHcGnNpzXMMejmpmK6/CrOWFImg1UPpYxgYs2pRQp34p+9T9Wld4Ggqy9y3vO5jqQaaHuiFszmTVz5Pjk0WTfPPsFoMwYk2A52DhJAgtuTcvnPrRGSoKcQ9ntAVB+U6BmRJNp3HxNROATzsAfHegOuohnJi86DewyZGy2yNlG7yMmkAmZFTnVHt0SZOdUJWwk4Kzpl6HNaHxF0pKs4b/7fij9CS8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(261009223027099003)(11063799006)(38070700021)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akpVYmdzL3RNSWdMSERrN1N3TndVSWYzaWNMdld5MXpkcCtqNlQvSk9sWFlO?=
 =?utf-8?B?ekhNT2ZJa04xQ0wyNHJETUE1WlI0SUsySmNDZTZCdTRuN3FYRGVPSU1vbGhF?=
 =?utf-8?B?aTU1SHgwWXlaWDlTYkR2aW9ycGw0dVhieC9sNE8xSUpodFZ0NktBTGo2azM2?=
 =?utf-8?B?d3M5TVd1RWlHdFlLcjI3SWF4b3VIR0psc0Fhak52RGJtMm1GRG11cGd2U0dh?=
 =?utf-8?B?ZXdVZFZzY0NtRzR0Y2dNOXJndFo0cjBRSE9PdEgwTFNtVTJ1VkFWYmlpNzhN?=
 =?utf-8?B?OXBQc1J3bUZaV0FFcEtRSkd0KzNTbDNCODFwdDlUWG16dWZqcW5Wemo1dWwx?=
 =?utf-8?B?ZXhWR1RlNU5LOXVGNjFtb00wYUo4V0pqVC9mUEhSRXAyRnFxR251UTVzcU55?=
 =?utf-8?B?R25JSXNEckM1L21TVVdraElXTWM5R1ArM1JDaEN5dVRSb0J3bjdIeGp0Z201?=
 =?utf-8?B?Vkdxb1AzYW9Uc3FoSXJmbytuY2JNS0lMRkZSSm5JQ05XdktqR241bkcrYzhM?=
 =?utf-8?B?dzJsRzUwZ3Y4bU43TTB1T1MxZmNEU2RyRFJia1FrT1lIL0lRUHdxcDlCdDJ2?=
 =?utf-8?B?N2FkOGxpRGM5MVdKUUFkTkJOK3dCcnpLT0dNKys5Qi9GdXNxbjJSS0RYZVBv?=
 =?utf-8?B?bVg3andjdlVaUEtBTHZIcVNSbzBjM0xmM21EbS93Rk1mdHJHK3krdU9IakFK?=
 =?utf-8?B?Q0V2UVU4ck9jUUtta01MekRhcHVVYXE1QlZ4dTB0MkJuSEZ4a2dVRVV6aTM3?=
 =?utf-8?B?ZDBONlpUSHlsOGFjcUdUeHJUK3ZyK2tERGxtUDlCL3g5aWkxQTEvV3hXa2dH?=
 =?utf-8?B?d2w0YlE3NGxpbC9lR2JXT0t2L0crc0JPVE5tQXhyVHp0a0Y2dHYxYVk3WW9L?=
 =?utf-8?B?YlA1RzlENHFsRnYwRE5PQzhQcFRMVXRGNThSVUtYQllHeG0rMm1aM2Z5NWFD?=
 =?utf-8?B?UVI4R2h4T3BSOU5ScHZXWGxxOWx0b2hqYnVKZG1QVTZuWmZoZStvTzlpTnVM?=
 =?utf-8?B?WEFLV2ExUGNmaWZvcW9EekZYSXN6S1lESm9LWXZIUXpuZWNPSVZCb1RqUzkv?=
 =?utf-8?B?d3B4eGdwV3JjMVU4VTV1c29jYmVHTTJ2Znk3N2xmWE9xVVg0TEtUTWx5bE4z?=
 =?utf-8?B?M3ZTOVh0MldJRnFWWXg0d0orU1ZTNGQ1VDFCRzRmYnRUWWJCMzVzMlVUdGYv?=
 =?utf-8?B?NW5tRmdHNEQxR3FjTjVjN2FSSlNyVnhZTy9GM0p6UkdKZlRycHp3OElkZklT?=
 =?utf-8?B?K1VvbFpQdnpnaHVQWHJMcUlTUGJKWTRXa2R0TlVpTUE2NTh3RFRrTmEyUmt1?=
 =?utf-8?B?cjlYN1lZVGVxMnpneW4wZGNDZDRPZHRiRThYYyt3NzhCVENoc3dQL2RJZXht?=
 =?utf-8?B?SDVGdTdST3lPMk4xYzBqdzVXVHVxbzE0T3Rtc1ExRVJjNE10RHo2dHZ4OXZL?=
 =?utf-8?B?MENqSVh4bFN4djB5dkJsWGJ3U2dMUkVnWG9vWGdlaUNVdit0WDZjVG5IS1lX?=
 =?utf-8?B?ZGkxQng4M0pwT3Nja1FJV3diT0JQTWZ5RjIwNUt3eVhIQWZlR0Q3UHp5NTR1?=
 =?utf-8?B?REJRWjNqVlFWNXA1TFJRZnJVNmRPYitzMHRiTUtLT3ZuU3crU2xic0FraCtO?=
 =?utf-8?B?MEhIdkZqNUpYWTNTNmN0M3NORm0ySnZUcVBZejdjVmNKRStDcUZxZGpES2I5?=
 =?utf-8?B?clF0TTVoWjVlODhjcmJaSk8xdk9iNXA0UDB5R3dPZWtDbUxoQTF2NDE5a0RV?=
 =?utf-8?B?L0lGOFdQWDRwUmdmTVNPZzY0NjdFNzVDMlRyT3pOTit1QXFpYWI0WmlpVCt1?=
 =?utf-8?B?Vnc5N2VJZ1N0UE1FWEtNRnllWVhlS2tJazIrMUZBUUdkRjlrK0RQb1hhZW9x?=
 =?utf-8?B?eFdzN21YdDZPajdGbVIzQituWDFDeTYyRjRnMDZvZm5XSjdMRmgwRUdLVktp?=
 =?utf-8?B?ZTkxZnJ1VVNtZ3ZSMmVBeUZLdlliNFN5K0lxU2lTdjRla0tjWSswd3NzRHhY?=
 =?utf-8?B?WHVEL3hMSkFVeC9uU1E2Z3E1Y1J0OVl1ZGVKWCtRdkUzejRtV2lMbjk5akhy?=
 =?utf-8?B?KysvenN2c1hoZzNYZHp6U2Q4ck5HQTB1dlNKTFhEMld5T2IzUmhPQWNSZ3N3?=
 =?utf-8?B?S0lnYVJzMk12S2tIU1ZrdjFZSUxndHBja3A1YUNuck9FaEhKYURlQVV5UlVF?=
 =?utf-8?B?ZENjQ1YrbHRSUmZYeXV2c04xUUM5RWoxWXFJZWJybGpWYXhpaWwvLzcvRVFZ?=
 =?utf-8?B?MGlkb1h5SnkwTmgwQnZRLzA0WFBKaTl6RkdBUGZkS0I2SktMTFc1bE92Y3RO?=
 =?utf-8?B?RWkxeTBSNHkrTW1FUm5wZXB6dUNZUXkwRlN6TDhjaFE1ZmFFU1pNS3ViNUNS?=
 =?utf-8?Q?5YgS2GF7q5Jpf6Jg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5510C1115B1FE945BE83104FC13FC743@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AVp5TbmRyiPTbVVzIx+RpEXEApyF8iPvf1mdx/fTrrr3t6OYOJuAYt+IzqlelHOfDfl+C/CkTqhygc/K3vMQRW38JbTW/xUa5bHqP2BMJdMRt7J2kZmI2+h0rTPZg88VLFJaRLDC0CPZ5jlVrsRNsmwkNzfqb+zqMxkQFrXUJhH23Io/R2XZZ9/eoOATfS/Umj/6U6l0V2/wVyrmD2LqRMRBt1gudE94OGqNjTRicTHe4brVDv6Oz0LTZQ3RM2cjnTWsD1OMP2jgRUOYf5WqRPVfBmynQOe38aYS0cAKcCmyWCGacWNo22cG+1j6f02ANZdiMmaOmGtgSTQwC0Ngkg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c40648-f42c-4017-94d1-08df2878a964
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 15:51:21.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ai3Fh3hDikgFKTbu3YOtoe/am59YNImi8zEyNxUwFTKsKJL+cMH8UXwJcY80wmPkObdWZFKHImVMiTJZef2RWcjFq1eUX3y1Gm4vUX3bQPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7495
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTEwLTEwIGF0IDA5OjI4ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
IE90aGVyd2lzZSwgSSBkaXNhZ3JlZSB3aXRoIHRoZSBwbGFuIHRvIGRyb3AgdGhlIHRlc3RzIGZv
ciB0aGUgb2xkIGludGVyZmFjZS4NCj4gPiBUaGF0IHNhaWQgSSdkIHdvdWxkIGJlIHRocmlsbGVk
IHRvIGhhdmUgYW55dGhpbmcgdXBzdHJlYW0sIHNvIGlmIHRoZSBzZXQgY2FuDQo+ID4gYmUNCj4g
PiBzbWFsbGVyIG9yIGZhc3RlciB0aGF0IHdheSwgdGhlbiBJIGFncmVlIHdpdGggdGhlIGNoYW5n
ZS4NCj4gDQo+IFRoZSB2MTUgYWN0dWFsbHkgc3VwcG9ydHMgYm90aDogb3V0LW9mLXBsYWNlIGNv
bnZlcnNpb24gKHBlci1WTSBtZW1vcnkNCj4gYXR0cmlidXRlcykgYW5kIGluLXBsYWNlIGNvbnZl
cnNpb24uDQoNCk9oLCBobW0uLi4gSSdsbCB0YWtlIGEgbG9vay4gUHJldmlvdXNseSB0aGUgZGly
ZWN0aW9uIHdhcyB0byBicmVhayBpdCBhcGFydCBpbnRvDQpzbWFsbGVyIHBpZWNlcy4gU28gSSB3
b3VsZCBoYXZlIGFzc3VtZWQgdGhhdCB3b3VsZCBoYXZlIG1lYW50IHN1cHBvcnRpbmcgb25seQ0K
b25lIGluIHRoZSBpbml0aWFsIHNldC4NCg0KPiANCj4gPiBCdXQgaW4gZ2VuZXJhbCwgSSdkIGxp
a2UgdG8ga25vdyB0aGUgcGxhbiBmb3IgdGhlIG9sZCBpbnRlcmZhY2UuDQo+IA0KPiBTZWFuIHRh
bGtlZCBzb21ldGhpbmcgYWJvdXQgaXQ6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9h
a1VkaFZzSWI3QkVxVTd6QGdvb2dsZS5jb20vDQoNCg0K
