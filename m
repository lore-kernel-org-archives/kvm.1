Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F352EAB72
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822184; cv=fail; b=C1t/cz0jz8r5TOYweHDYmh8NIfBN8T0+SMmxP80g3TkCZocdUEpPIX1yJOu6tAM4eMQtiGXHeJap+/EoaSKAIplmPXs2PkKvXvSB7QAJKaYTtUuTzmci0VQV8La2Pqjyz0lBEjBd2SaVHkolCoYB2u7o+ZUUlhpkgyVWXS77OJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822184; c=relaxed/simple;
	bh=yjbnqNh6hTVqntk9rc1lvzIwc1oCect2/zgkdVUE8WY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pW9eRr8OjqLp2ppq34mv/npwVYXN3NRDyXH/BIAuNtnM3iin05ozY7eCGP3epfcfuZL/VHTjkOT74Yk4jDirmpkxBgJAa626wtZ6bv8URNN89/Zlb8Hkg5nrUK0HCkzYj79jgFSWC7qyCBLA2lMzRuSV/A0V6ysoHYa9mjNw/J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2K8Zvda; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2K8Zvda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776822181; x=1808358181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yjbnqNh6hTVqntk9rc1lvzIwc1oCect2/zgkdVUE8WY=;
  b=W2K8ZvdahizsDBvwEBqZPoIuaukM1WUOP9ghb3x1XwmDZRCU4vemW2Ze
   sHiUc1jkWofz7I+03CrF7ekCqUX+WLmpc2Yp4E+fIwZqIzjX6th3I5bV2
   r+G46Ih3w5j6pbrba4mQ4VVpnPGOZaHAWx3oAIGd1hDcFLGN2PImhoFgC
   zmgGbpioyMBo3TcLqLRjN4umSfH0RDnttBoYnRQheSPYqb2+wz7WyOO28
   JQaw6pmeTA3h55BHL+TY5pPvnR0aWXIX7QjiQcwnAC2iy2n8Bt6BU0TG7
   1JNZxj8DsYjin76yiVTa1aoCSQziFB6pB/OThGWYtU1qc+rLhoCzOKfvH
   Q==;
X-CSE-ConnectionGUID: Oo44Mjw4THaKZkbnBvVyzA==
X-CSE-MsgGUID: 134jQLIHT+G0AqKrQkq4Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89153264"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="89153264"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:43:00 -0700
X-CSE-ConnectionGUID: 0HUpY6MsQXO4YcnrLfssqQ==
X-CSE-MsgGUID: EBOkRUfDQJOAGnQmBiv2uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236216612"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:43:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 18:42:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 18:42:59 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.15)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 18:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klrRDB1JBMx69T85+aiyKMJLywaZ21L8xzwnDCKs0H4gl6xqIuPDDzgTZQYQfa5IClhlwZbiEmWkgdl3bciyQKy2ULKHOr4uD5qTB83mTsSAss2pswjYHPr/z4DnaMpZIVy82orBxhiv9Yn0MGWoEthLzskKwv2fZfUHxoFRcFOzQ9kwyJgEBPsEXwmMIqsO5dPNc+gJMASLeAjsxxclM30Spya6nuZbeC6P1l+5nHxR7qlqAkS0GX4kj41XVe2YdFtfX7a4sEUXOI/t6WB/cX3Uz80OJ29Al4iJRQUD2QQx5rhhn3RX08DwWPRWsvli/Y/0bBhwFFZMRcasYvn3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjbnqNh6hTVqntk9rc1lvzIwc1oCect2/zgkdVUE8WY=;
 b=Fg8x8pkq9tCV2xrAfMqkMkq7UypnnM97wq79FezdOgtW4be1TaLXMlCArCzRZ23gNDis9evBRTREdGBPbu0NYQurGIk6hq31ZH5RTLkqUPKf48meQ/OV4w5GaQYGIgOHAI0tcGvwHL7G35r/6rBe5ggDPAWZD3Gae+9kfbIyah3etVBhFkXGYixbb4Ga4IHDdSd3avm/MszPFs0KZGgPhPoNxXNgLh90Sp8vYPMWsN3aKWsOOD31YNtmbpgXgiLsV6n3/OzhzUReqrY4kKZlKeJfZoSUVnhWqAvDcHi0G2eGFr8SQh2AUErizicJ1uld5n44E6fK25/VtQuVmCyLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.16; Wed, 22 Apr 2026 01:42:52 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 01:42:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "nikunj@amd.com"
	<nikunj@amd.com>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Thread-Topic: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
Thread-Index: AQHcxliL7ApYp79orUu4JhjyJLC0JLXnk/4AgAIguwCAAJHqgIAACw0AgAAURYA=
Date: Wed, 22 Apr 2026 01:42:52 +0000
Message-ID: <977e805339a29ab789650aa18cd320dd1e9e0c25.camel@intel.com>
References: <20260407063245.2755579-1-nikunj@amd.com>
	 <20260407063245.2755579-8-nikunj@amd.com>
	 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com>
	 <aeeS7LDPJ6NCy3Uw@google.com>
	 <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
	 <aegWmKk8uK5r10dM@google.com>
In-Reply-To: <aegWmKk8uK5r10dM@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA0PR11MB4752:EE_
x-ms-office365-filtering-correlation-id: 45eff984-2fe9-43b3-1649-08dea01077ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: 43RQkfnbqMtFmpvmWFoHYS5/0qlApCFvPzyakYSKL4OxHjLiAtJGYq0osPWo610IJ+d3Gufqb3hky6fd7PGr6sPvJ9gVyl9cnToYfpcNG6AE56zE5x6SshHMC0vW+pyt/bB8jqxHNxhthP4gxo/wFZlVZSRENRS7t1KGX5xPaDjl1RKmLoIi8SAAkCZ/2JHvIZptVErA8apMrI8WjV3fmUbnjnTwiuH2TRoiXrY4wM2AtY+j8Yv6KRhocwgGWJzHCulirgdWGk99u/PapZojODbq+6mc1kmt5NbLdONTw7qAAeLiBDi2s9X0ED5SHiuxpPv5hTZbMKcaCPFeG5rtgRsloOckgZSEXVWSrr1fe2PBZter+XtzKLsMVJV1vRzT48InTmvVGPZb1j+YN2tfoKKLiASdmc135mAwc1IQf0pQ4U3LZi6fgSJLtFhJift4n5idDBhuJlq/NnCyW0Fi8bYaFaeRDwdKHnwee3eP728OQtMAbZkm32jzqNjb/5DvNLeRqZ5DB3uqwNtONg2wEq40KvcIkgL6l6TGM8Lp9RW83yljJoghUBnqpnJwtaoiFdLgexH/Y3t+elQCti9PJA6WEQ1XjGUZE+z7KCwvTssraLaqPfJzsafA8VPQKP04Bi/G5y65T3GlU97ggjsJ9SHuDaDIhrM9IVHA0kBNFh21QV0Oih+75mkddcHhZuNsNay4Jayc5Y9fMJCQsepo9Z3lPHXiYgdv12HSB0eowOrvgsM5rh5Sngme5kETxq5M2XD6UA9rmOo/7ufcDUn7I474y7EFSjXwAqxU8c7ytrg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUZCTEp6ZWE5YXJpeUtpNmh2TksvV3g3R0VmMkhrR0V3cWdCcndURmpCZmNQ?=
 =?utf-8?B?YmFwcFFFVEpLa3Yvek5rdWwrbnorMGxiZ1B4a3NqNjRFT2ZrRHpaSFN2U1hn?=
 =?utf-8?B?SEhiVUxoR1hNUEhhcGVjOFBUU0JyZUx4MlYyN1NqY3hpZkpPbHRtUDFuWEY4?=
 =?utf-8?B?TnRLLzc2K1Z3eHRjODBHcVllamM5eGVpMjQ3QmdLeDUxaERlOFk4ekFYUDdY?=
 =?utf-8?B?bG5NanAzSFJ6elArdEZHOEZycytJSGxkcVpKV25taC9ncXdpQi9QZHFOS2Jr?=
 =?utf-8?B?bFljemRET25INHpBY1FUWUJYSWFHbmZRMlVJQzJFSTVpMlZ4K0pCa1ExdVg3?=
 =?utf-8?B?TUR4d3U0blVVNkZhdHlVdk9UL1RHV1F5T1AvaUl4a2lXaFpyUnoyR1hGb2Fu?=
 =?utf-8?B?VFpzWm5qMG1ibG1wSjdzOGI4d2pJMmJjdjhhc2cvMW9jUTBmdGhlNDJVSndH?=
 =?utf-8?B?dU12ZVJPMldvZ29iRjRlS0NKaEZPTHV2bnpiSnVaMG81dXpuRkxRZm1KbCtI?=
 =?utf-8?B?VytvY1dPNHBnUU5sT0xIV2xFUHFqR2JIMGllamdZQ0JJM21TWExXazFvMHFM?=
 =?utf-8?B?dUk0VjkvT08vaWh2dDVDY0h0Y011OXRuSnZiZlZFaDBXWmdZSVk5YmpzdWZH?=
 =?utf-8?B?ZTlhdkd5Q3NDdEJ2aXlVTVFFTmk3Y2s5VWdOQ1pwR01JTkduYjEvMHNZZTFT?=
 =?utf-8?B?TWhINGJ5TGY3WU5aaXFNdThJS0lucHMyLzRoN0pnQWxOTDFPV1dRVnE4ZXVX?=
 =?utf-8?B?OHd1NVpwMXNtOGFyaXJaRFAvZzd0TXBrdllVRVY0VzdIQW8zWUF2VjhVcU5I?=
 =?utf-8?B?VFFhcnZ3TjlXNG5JdUJsZ2N6ZTlZN1dtMzZrcXJKcTAyeXNQa2J5dGN4RnFS?=
 =?utf-8?B?eFFBWUc1Q3NaTk9KWUN0RGZNTlArOERkRnBJTktJclFTNHJoMXNoSUx6amdS?=
 =?utf-8?B?MnUzNnZwU0Fqd2t1clpZVm91ckNsd2FuSHljR2pGU1NWclJicXY5UzdYV1Zk?=
 =?utf-8?B?L3R0WnMyNkRMbHdEelpncVU1R1NYN3JQWW1haDR3V0lPQSt1WDJ3TTVSQmdj?=
 =?utf-8?B?OW9yUGEzTm1uamlYSWJHK0xFNWYwUlNFNVdoSDBDcjBoQzJKbFp5azg5eFJC?=
 =?utf-8?B?bmY5QitkNnFCcFNpeWJEeWxIYWc4VGwvbGduaTZ2MzZCWUZHa2hsVnI5eTF0?=
 =?utf-8?B?d0JyMjJJME9idDhuNzcvWUhiYWUwenFUd3d6ckJBVGMwMVl0Mm40eE9MY1Ra?=
 =?utf-8?B?VVVSNnZPVzBkNzZlbnh5QUZzU0NhNDA0T0x3eXg3RWhqU0JEZE9zSnpLTmR0?=
 =?utf-8?B?NUtPUUd3emw5Nm5VK0xzMTFnd1BiUjFKSVpOZEtNTGt4Vm5TbVhwQmpPM1Uw?=
 =?utf-8?B?YzZtWWpoUTNRZFpmOWtiTTJxSmRNL0FENURHa29DRnZKSnQ4WlVXUytFWkM5?=
 =?utf-8?B?RkFXY0c2UnFLWGFYQWhjUUJkNjNYRUU5ZUVsYW9Gdk5FUGY4Tis5QkUrVXov?=
 =?utf-8?B?NStNTnR4WVZGcHdzYkZ3UnJ5UTBjRnBiY1NtcDltZ1BHY1hPd1VWTDNhblpU?=
 =?utf-8?B?RXRnNmhRczdnQW4yTUY3ZUpqUWUwMTJOOGQ2WS8yeThmRHhVa3YzdnV2VWx1?=
 =?utf-8?B?dVBUeFRqZzBYY0lwN3FFWStXY3pEVkFLODF0Wll6WEJzTkJqd05vQnk0S2Q4?=
 =?utf-8?B?R2FPdnRFQzJabG1XU2J3TE0zQlBoWHhPekY3bUJzYkVKdjYrS1ZPb0VuMGd6?=
 =?utf-8?B?bW5DRTlOcUxQbUdCRllQY1VheTVrd093MkdrTFBmdUxvcXp2MVB5NkVYcFp2?=
 =?utf-8?B?dlNGQ2tvUXAzRUk1ZkZURnArNkZTOXhJajRMVVVWL1g0WHNjdWJKMmtQeTg3?=
 =?utf-8?B?Yzk4MFdHMUl4dWtiT3hndUZSaGY1M2t1aUwwRnU0cytmaVhHdk9rZzZIWnAv?=
 =?utf-8?B?bGh6bFJRWFRqYVN0eW9CSTR4Lzc5TS9tR1ZacU5TMFUrdUpNSzBtMnArckFw?=
 =?utf-8?B?MGdUNXdTa2RzanlrRDhyRW85Y3lBVVNXQkFBVzN2QS8wNGNibllIRjlDcGNI?=
 =?utf-8?B?UGFkemRlTG1tWWhBRVQ3MDgzSGw5Tno1OWlWc0ZnSTg5aitWTlNLYVo0Zkk1?=
 =?utf-8?B?Z0pHU2VkMXd3eU5SR3Zja1l6OGtUVE1OTHMwOUNCNGRhd0R5NWVMeFRndDM3?=
 =?utf-8?B?WXJWbVpJN1hvWFAranJ2YTBOeitmRy96emhkMlM0UHVmU1hmUFUrVnBQdjNk?=
 =?utf-8?B?eXRYYXFPM2NEZGNUVHczSVFOQjVkR1hLN3lrTkpoR3BkdU5NZ0NzNmgrcCs1?=
 =?utf-8?B?Q2h0MnErRTk2Z1Ixb2NHUExkakFtSlB0R2VEMmN0Z1Jvc2l3WVdmZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C6ABCAAA907054CBF2E09ADEE1853DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LzPBSu9YZD53F7mky1RL1w1uwW1SlKD6Avo0Xyw29WAjbRFbBGE8L/HsLL1pJ/pKcCm/a1yxzbS3aIZPqKiTqj6PGAQsjS8z4CvXKiLkPi08P3JpZjVde5mDstB3pltffhLbgXgwIJl7/bIkaKwN52zOxru6LPJSD13bKi7dudRdK6GfB8Nn8+pejJxVVwAZGs9fjAZLwvP2/KlhnrARCaPmW8JKvfPLBUlpJ+yGSLVKCtYLBC5SVY0+PHEem5JbLI3bTW5z4/iOHvbsZ6NXJN7F5sP5yryYXLqtsen/d8xQzPGq2igs8Jat8yIyqFMLAjEM1JvjQ1TEQqNBdwPe4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45eff984-2fe9-43b3-1649-08dea01077ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 01:42:52.1281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20h5Rz2XZMESE8MoRagmS/HImOUTxXFwVV9gafh2sOd8vVGcOWCe/jLqrGd4SMva1vc3YlCgHUUNLJUuNHvMuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDE3OjMwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUdWUsIEFwciAyMSwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgMjAyNi0wNC0yMSBhdCAwODowOCAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToN
Cj4gPiA+ID4gwqDCoCB2Q1BVIFJlc2V0Og0KPiA+ID4gPiDCoMKgwqDCoCB2Y3B1X2VudGVyX2d1
ZXN0KCkNCj4gPiA+ID4gwqDCoMKgwqDCoMKgIOKUnOKUgD4ga3ZtX2NoZWNrX3JlcXVlc3QoS1ZN
X1JFUV9FVkVOVCkNCj4gPiA+ID4gwqDCoMKgwqDCoMKgIOKUnOKUgD4ga3ZtX2FwaWNfYWNjZXB0
X2V2ZW50cygpDQo+ID4gPiA+IMKgwqDCoMKgwqDCoCDilILCoMKgwqDCoCDilJTilIA+IGt2bV92
Y3B1X3Jlc2V0KC4uLiwgdHJ1ZSkNCj4gPiA+ID4gwqDCoMKgwqDCoMKgIOKUgsKgwqDCoMKgwqDC
oMKgwqDCoMKgIOKUlOKUgD4gaW5pdF92bWNiKC4uLiwgdHJ1ZSkNCj4gPiA+ID4gwqDCoMKgwqDC
oMKgIOKUgsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUlOKUgD4gY29udHJvbC0+
cG1sX2luZGV4ID0gUE1MX0hFQURfSU5ERVggLS0gUE1MIGJ1ZmZlciB3YXMgYWxyZWFkeSBmbHVz
aGVkDQo+ID4gPiA+IMKgwqDCoMKgwqDCoCDilJTilIA+IGt2bV94ODZfY2FsbCgpOiBOZXh0IFZN
UlVODQo+ID4gPiA+IA0KPiA+ID4gPiA+IENvdWxkIHRoaXMgcmVzdWx0IGluIHRoZSBoeXBlcnZp
c29yIGxvc2luZyB0cmFjayBvZiBkaXJ0eSBtZW1vcnkgZHVyaW5nIGxpdmUNCj4gPiA+ID4gPiBt
aWdyYXRpb24sIGxlYWRpbmcgdG8gbWVtb3J5IGNvcnJ1cHRpb24gb24gdGhlIGRlc3RpbmF0aW9u
IGhvc3QsIHNpbmNlDQo+ID4gPiA+ID4gc3ZtX2ZsdXNoX3BtbF9idWZmZXIoKSBpc24ndCBjYWxs
ZWQgYmVmb3JlIHJlc2V0dGluZyB0aGUgaW5kZXg/DQo+ID4gPiA+IA0KPiA+ID4gPiBBRkFJVSwg
bm8uIFRoZSBQTUwgYnVmZmVyIGlzIGFsd2F5cyBmbHVzaGVkIG9wcG9ydHVuaXN0aWNhbGx5IGF0
IGV2ZXJ5IFZNIGV4aXQuDQo+ID4gPiANCj4gPiA+IEh1aC7CoCBUaGVyZSdzIGEgcHJlLWV4aXN0
aW5nIGJ1ZyBoZXJlLsKgIENvbW1pdCBmN2YzOWM1MGVkYjkgKCJLVk06IHg4NjogRXhpdCB0bw0K
PiA+ID4gdXNlcnNwYWNlIGlmIGZhc3RwYXRoIHRyaWdnZXJzIG9uZSBvbiBpbnN0cnVjdGlvbiBz
a2lwIikgYWRkZWQgYSBwYXRoIHRoYXQgc2tpcHMNCj4gPiA+IGt2bV94ODZfb3BzLmhhbmRsZV9l
eGl0KCksIGFuZCBzcGVjaWZpY2FsbHkgY2FuIGdpdmUgdXNlcnNwYWNlIGNvbnRyb2wgd2l0aG91
dA0KPiA+ID4gZ29pbmcgdGhyb3VnaCB2bXhfZmx1c2hfcG1sX2J1ZmZlcigpOg0KPiA+ID4gDQo+
ID4gPiAJaWYgKHVubGlrZWx5KGV4aXRfZmFzdHBhdGggPT0gRVhJVF9GQVNUUEFUSF9FWElUX1VT
RVJTUEFDRSkpDQo+ID4gPiAJCXJldHVybiAwOw0KPiA+ID4gDQo+ID4gPiAJciA9IGt2bV94ODZf
Y2FsbChoYW5kbGVfZXhpdCkodmNwdSwgZXhpdF9mYXN0cGF0aCk7DQo+ID4gPiANCj4gPiA+IEdp
dmVuIHRoYXQgU1ZNIHN1cHBvcnQgZm9yIFBNTCBpcyAob2J2aW91c2x5KSBvbiBpdHMgd2F5LCBp
dCdzIG1pbGRseSB0ZW1wdGluZw0KPiA+ID4gdG8gYWRkIGEgZGVkaWNhdGVkIGt2bV94ODZfb3Bz
IGhvb2sgdG8gZmx1c2ggdGhlIGJ1ZmZlciBvbiBhIGZhc3RwYXRoIHVzZXJzcGFjZQ0KPiA+ID4g
ZXhpdC7CoCBCdXQsIEkgZGlzbGlrZSBvbmUtb2ZmIGt2bV94ODZfb3BzIGhvb2tzLCBhbmQgdGhh
dCBvbmx5IHdvcmtzIGlmIHRoZXJlJ3MNCj4gPiA+IG5vIG90aGVyIHZlbmRvciBhY3Rpb24gcmVx
dWlyZWQuwqAgRS5nLiB2ZXJ5IHRoZW9yZXRpY2FsbHksIGEgZmFzdHBhdGggdXNlcnNwYWNlDQo+
ID4gPiBleGl0IGNvdWxkIGFsc28gYmUgY29pbmNpZGVudCB3aXRoIGJ1c19sb2NrX2RldGVjdGVk
Lg0KPiA+IA0KPiA+IFNlZW1zIHZteF92Y3B1X3Jlc2V0KCkgZG9lc24ndCByZXNldCBQTUwgaW5k
ZXggdXBvbiBJTklUIGV2ZW50LCB3aGljaCBzZWVtcw0KPiA+IHRvIGJlIGZpbmUgc2luY2Ugd2Ug
YXJlIG5vdCBsb3NpbmcgYW55IGRpcnR5IEdQQSB0cmFja2luZyBBRkFJQ1QgKG90aGVyd2lzZQ0K
PiA+IHdlIGFscmVhZHkgaGF2ZSBhIGJ1ZyBmb3IgVk1YIGhlcmUpPw0KPiA+IA0KPiA+IEhvdyBh
Ym91dCBkb2luZyB0aGUgc2FtZSBmb3IgU1ZNPw0KPiANCj4gV2UgZG9uJ3QgcmVhbGx5IGhhdmUg
dGhhdCBsdXh1cnkuICBPbiBTSFVURE9XTiAoZXZlbiBpbnRlcmNlcHRlZCBTSFVURE9XTiksIHRo
ZQ0KPiBzdGF0ZSBvZiB0aGUgVk1DQiBpcyB0ZWNobmljYWxseSB1bmRlZmluZWQuICBJLmUuIEtW
TSBuZWVkcyB0byB3cml0ZSBfc29tZXRoaW5nXy4NCg0KWW91IG1lYW4gS1ZNIG5lZWRzIHRvIHJl
c2V0IFZNQ0IgdG8gcmVmbGVjdCB0aGUgYXJjaGl0ZWN0dXJhbGx5IGRlZmluZWQgSU5JVA0Kc3Rh
dGUgZm9yIGEgdkNQVT8gIE9yIHRoZSBoYXJkd2FyZSBpdHNlbGYgbWF5IHJlc2V0IFZNQ0IgdGh1
cyBtYXkgcmVzZXQgUE1MDQppbmRleD8NCg0KPiANCj4gSG1tLCBhY3R1YWxseSwgaG93IGlzIHRo
YXQgZ29pbmcgdG8gd29yaz8gIERyb3BwaW5nIFBNTCBlbnRyaWVzIGp1c3QgYmVjYXVzZSBhDQo+
IHZDUFUgaGl0IFNIVVRET1dOIGlzbid0IGdvaW5nIHRvIGZseS4gwqANCj4gDQoNCk5vdCBkcm9w
cGluZywgYnV0IGp1c3QgbGVhdmUgUE1MIGluZGV4IHVuY2hhbmdlZC4gIFRoZSBQTUwgYnVmZmVy
IGl0c2VsZiBpcw0Kc3RpbGwgdGhlcmUgdW5jaGFuZ2VkLCBhbmQgUE1MIGlzIHN0aWxsIHdvcmtp
bmcgaW4gaGFyZHdhcmUgdGh1cyB0aGUgYnVmZmVyDQp3aWxsIGV2ZW50dWFsbHkgZ2V0IGZsdXNo
ZWQuDQoNClRoaXMgaXMgdGhlIGNhc2UgZm9yIFZNWCBBRkFJQ1QsIHRodXMgSSB3b25kZXIgd2hl
dGhlciB0aGlzIGFsc28gd29ya3MgZm9yDQpTVk0uDQoNCj4gRS5nLiBpZiBhIFZNIGNyYXNoZXMg
d2hpbGUgaXQncyBiZWluZw0KPiBtaWdyYXRlZCBieSB0aGUgaG9zdCwgdGhlbiBpdCBjb3VsZCBl
bmQgdXAgd2l0aCBjb3JydXB0ZWQsIGluY29oZXJlbnQgZGF0YSBvbg0KPiB0aGUgdGFyZ2V0IGR1
ZSB0byBsZWF2aW5nIGRpcnRpZWQgcGFnZXMgYmVoaW5kLg0KDQpJZiB3ZSBsZWF2ZSBQTUwgaW5k
ZXggdW5jaGFuZ2VkIHVwb24gSU5JVCBhcyBtZW50aW9uZWQgYWJvdmUsIEkgZG9uJ3QgdGhpbmsN
CndlIHdpbGwgbG9zZSBhbnkgZGlydHkgR1BBIHRyYWNraW5nLiAgQnV0IG1heWJlIEkgYW0gbWlz
c2luZyBzb21ldGhpbmcuDQo=
