Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923638C41B;
	Fri,  5 Jun 2026 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646377; cv=fail; b=phvqksV9sZhnN0QVb8rLE5s/f+YBmUApnup5X7LDQXAigp0ZROWsW62p26JML2OIn9vcqMmVCE8u1b7PSxr6580XKmM8FSb0UhJhsd+n1t0OXWAwGUz9rP50dR4Dk+zkhqK4KMy+7RnQYWa4gPR1IIsaiT7RIMOlaBA73YK/drU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646377; c=relaxed/simple;
	bh=j+v+O0kbOCoOEi5C5ng0755q0nnfVDFfcmMREjRScYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=co7+5S1YrMilHBCH7NQpa+9bZBIMkkoa085GYQnZCXJtR9PWsHoAY+inc1ARHGDnqJpCD64PySuR20LyxHS5RhDKz0Q9+SSNaWp1hKnXoD8ZoPNJIZThE5iL5rHFfr64UG0NyqT6UmZif5ZjBeNIh8eiUQGisw7tZCERbUKPzfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMSbSh2v; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMSbSh2v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780646377; x=1812182377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j+v+O0kbOCoOEi5C5ng0755q0nnfVDFfcmMREjRScYM=;
  b=UMSbSh2vVpYa5RxB+bn32+OvXoQQraGoYXR/esWF2Sqs3iqF0qnMMApC
   tqPUmKmd/Nm+QhjjnyPRAMCffyBgOcVddbp76Y6snSO8ee1/kw7SRJaGO
   G0WmVzfx8oDufPLUyGZo7NG2PdEAEjE3jkxBYsHXRmYnoY5mplFl6MJBH
   fDBgWOkWD6HXO+VaB1sM+zXIlzCyUfIc178G0ZkDZpgjiPIHti8NaXPz8
   cwxZH5b+G/M96QrpI4yJE6riQHkPLFxM4SuiNSbAeviMrwJ7lqGDbmuUd
   thIu/amUHbWf11L8TBpk5mMZ98NYInZSVCypxpGcZdtabr1/XKQNPuQgI
   g==;
X-CSE-ConnectionGUID: slPSCVsCTRiwlsMOyum8lQ==
X-CSE-MsgGUID: 5eTcdHB8ThOzljVS2K4nag==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81478606"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81478606"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:59:36 -0700
X-CSE-ConnectionGUID: L3GcEjsWSfuek4lBSzLb6Q==
X-CSE-MsgGUID: /mcZGmO2TBGCywmCPLEHzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244900073"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:59:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:59:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 00:59:34 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:59:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hmd3OljJueojAYUgTxG9pr3ZmG1eFlv4NxqN78JJCH/MA7YHNJ+u63zMazo5fIxYrotHd5TIoUZLW5geQ0kBwXkiqg12TdkGh5WExRFCXSRw8ZI+H3bV1favCNkLCvQbs6dbCrdc9G8jW7CIc1+Y9CO0un7kKvdx7WS/6xSehOlT7CGTNiCRsrK7ptqiK5Bq3oboGTEcLCwCgiosnIznhRhy1miXpU0X+DR53Z5W8u596fJZh4bKobPsuSQuWhi4cxNpDjLCEfikrQKite0B0xiNJ9foI6SzO+UcZBJSot9z/ZRfYUgFuGuOLG2C/vbsW1khbM/WYfCv76pQJGD2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+v+O0kbOCoOEi5C5ng0755q0nnfVDFfcmMREjRScYM=;
 b=QaY9TfHfC7dJ+N7TEGqIRfEJ/iac5YjbUedSj0CR7oy/s/T4PdH2HG8bm080WHhjTyW8slAwgMOk3ZjbiC6YxtVtBBLeRrSn/+XG6fmPzmGEAJyd7h291IwAQ3yDmLMnx8gf9Zg7wAM1FPEscJauRLsGV/rqLeav3KWebHh0kPA/r8/Md7znLKIjBf0kJ6gRYcKszOowaMsY8qARWzqePcldBVWbEPwTIqQWkhEw+vrd1R2gWYCKz/EHj0YAWzGYXo8XXJ6N9FG2ZBjghf186d3KRnc4Eoi/8M0byCCQRHmm9b9oIGPfy+PSK3BRXaRfvhqlxiwdDI+Wj0/IuAQh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS4PPF31CEE2CEC.namprd11.prod.outlook.com (2603:10b6:f:fc02::1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:59:31 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 07:59:31 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 38/40] KVM: x86/mmu: Move kvm_arch_async_page_ready()
 below kvm_tdp_page_fault()
Thread-Topic: [PATCH v3 38/40] KVM: x86/mmu: Move kvm_arch_async_page_ready()
 below kvm_tdp_page_fault()
Thread-Index: AQHc77nNPk+12RY7EUCmWvy+NTIg+LYvowSA
Date: Fri, 5 Jun 2026 07:59:31 +0000
Message-ID: <0414dd548d9dcb857a9d6f6c5f06010080729ca3.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-39-seanjc@google.com>
In-Reply-To: <20260529222223.870923-39-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS4PPF31CEE2CEC:EE_
x-ms-office365-filtering-correlation-id: c17a722d-3f47-4879-4ee7-08dec2d86023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099006|11063799006|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: yEkuefhAsxLpetNsvswlKwJ7tTnOZnESj0u3kuHjcpv5nUCBTar6W0rI6SQ1cJh4SrSAbQcBVVK4WN918MkIoWcgO9MHZYQpaumRbycpVRtW9Dh2dygIcWIJl4JPCgsPx/9Am5fa5BFFYCLf66MUA5b0H5cq9z7OachL9iF1b+9gHfCarVBF0dN2chtHUg5Rks03AV/PgpSz+9Dbg78dzAkBrWZIbr4/AUuruI2cgXz3X/22/57ui5CLJG0V5KklhXUp45e7UMnMWiYg+nPuO8sUTOMTQhkZvPa3+4Mf3bIVg1afyTBePPEysmi+16NtsLpqq/DDcJNFScwLciy2y9WUCSxe3hsSHyieXmjoMlqkvVPFPWnuZYg0/1t5UQ+yA/dJ+LoiYp0I0oI7KoSprlzPHUP0W4wE35zZ9W5tWM4NdmmsiPudgaxizxAFJL1ZSXOu+gfDcXQ0HIAEx4bSLtpmbVAhK0ryDUz8o0npJ8EXsbvJ2ZAO8SPS4EjhevW4L1aEDCnAD4EZX4SinbQGEzpCvnncWpNzWBDjngtjjEo7DAbnrXJpdqwFBSOqrCdCiyOjXY0+qZoX5ELB1FzYYnfyDxi0dRzZpGdj6fHvn/eC6MAaoJGgNyGEDZA1HONPpxx409ZUIxJB1XokIrqTCoUZHP/dENtLZw6VhiF6TXbHuI+JK8HZSAJ5gFJolRf8SybnMibIz9Q/C1fQQWcZFNKkBLDe9LzHxNTOJfs7JGqMBnhax33dvO5BvFFr2Rdl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXNJL005YjUwclQ3cUlkNDBJSlB6d01BQkhjWUJFS1FvN3dINThTamtrLzhD?=
 =?utf-8?B?MkZDa0VnZ3l6TlJxclFRWHpMeGI1dHREc0FsN3Q5TEhwOVlOSnQ1V1pndVJu?=
 =?utf-8?B?OTdGbFZNRDdRaDdjZm9XREVFTGJobDBMY0puNDllMmFQcEdwVkk5b21hMHNX?=
 =?utf-8?B?UW9tUEhqN3pUZit2N2RQUjNaN0dsY0tZcE02bFVZSHZ0RHZrR2pNcnN0NGJ5?=
 =?utf-8?B?QVptQ0FSR2VIek1qdTJwRitmU2p0eXZraFljaWtNRm96Z3Fkc0RHUVE1bDRH?=
 =?utf-8?B?d3ArdlJ5MzNCNmlVanNkTnp5NGhPRHMxR2Q2ZWo4WjhGNEZpOHllMzd1SzVh?=
 =?utf-8?B?cDVId1BGY0NjcmNBWlBsdm43YU5wQThQeTg4bHpMaVFwQWhoTmZDQWd2RXBG?=
 =?utf-8?B?ZDFGWHFCMUMwZkhRZitqdzc0eTdKaWV1RWlvbkJaR0dOa2EvVm9pWmpTVHlK?=
 =?utf-8?B?NzRDcXNoZC9ZYVg2ZUE2QytjSjZYSnlEWXpTblNxN3hVMjg5U01LdmZYVVlC?=
 =?utf-8?B?WHk3ZDVMYURkUWxPMlhxQWJucTVtNDlaZHpReFp3akRTYzZyUTg4ZE92VVc1?=
 =?utf-8?B?K0ZmK1VNd3RDZzNzK2tvcEFEamk3eVhYUlFuOHNJOXRBU1lKMm8vVU5Kck5l?=
 =?utf-8?B?R09wZmlqOVdjL0JrVzM0Vm4rNGozOVBsUHVLMkVhdXJsdDZRcWl4ZGVvQmV2?=
 =?utf-8?B?cEdwWHhaVWM3K3hLT1AzcDRYYWwvSXhxakwxTGZNMFhKWjljZ3lMUmI5Q3ZM?=
 =?utf-8?B?S0RTbW5sR1pmS3ZpcjJjSXhWRmZhdXdkTERXSE1qMzhTM0VGcWRReUxxa1lU?=
 =?utf-8?B?ZHZtcjlKaFFzYk5teUtxQ1hobFVkVktIalc2WXVLV2dFSFBzejJNWWdTMDdk?=
 =?utf-8?B?aUF4SEwwUjRha1M1anhiQ243aVBsUWJyNUtacVVaZ0hXUWxUWVZJWkpRSmZL?=
 =?utf-8?B?ZjE3a3lUT3IxQ0JEMXVCYksxa01PYkJiSWZFY2NjN0hDWUk0bTlOYkRTL1Jk?=
 =?utf-8?B?ME1qbjcwaithUXBtMkpnaCtrdnhPRUJWeFFPbEU4a1pDUkk3aWJIY1RkaG9n?=
 =?utf-8?B?UWlyZkkxUUhveTljakdlV1RUaXlvaG1IOHJ4ZTAvSlAxVXBKalpMdmR2OFI0?=
 =?utf-8?B?MDRSMndoQW12R2hKM0JiKzZwKzUvZWhOMlJ2NE5ST0c1YlFJWkdzL0p0NTFq?=
 =?utf-8?B?cXcxK09kcEo5YTJFbGRGazBaYmluLzZ2VlM3UFZiYWwxMUk4ZzBad0F0UGpI?=
 =?utf-8?B?cHJKaFVxUWNGVUtXUGx0NWxhejF3V2JEdGV1OGtBSTZTUm9DZDBLQkNqOW92?=
 =?utf-8?B?ak9CU1kxeDJwa0h2NW5MQm5KeWcvdTY2aDE4QXVUQndoWHFsQnRwenQ5L3dx?=
 =?utf-8?B?ZzRyTWQ5Y3YzRzdkaUI3S2NVY3FuWGlZeE0yY2NWQk54K1FaQ3dvMldJZjVl?=
 =?utf-8?B?Y1dkOWQ2WlFodEJDeVFNdWQ4RjRqb1RxOFhVQ3RraUlZN2plZ3V2dStPRjV1?=
 =?utf-8?B?SXFOUm1QZDlTMDBCc0hmeG45aW9XQ2RUcUE1ZFB5OFRueUFiZExDSFExSnJx?=
 =?utf-8?B?UVViTEVqVXJ3WjViczBhSTRNVFJHeTBIRXlqbGlqWTlVOU4xY0tkQk83Z21o?=
 =?utf-8?B?U3hST0ZHUUZiSDVMZ21YcUY4RWtDMmtjc1dxQmV3M2xsV2g3QmdSNkxucDA4?=
 =?utf-8?B?VHpCZDhQK21yV0NmYng4NnBTbFlEaDhKOWxXV3VNWlhKVE1QeFlIbDI1aysy?=
 =?utf-8?B?aVgwc29ZdkdIeXBHUDJRQVpMTGc2SkFrUlkvRnoxZWZpZ1k0YUxCVERTbjJ5?=
 =?utf-8?B?L3JxcGxCV0N0aFBIVy9yTnh5YzhPUlc3UmVZTitlY2p3R25CYjFDK05ackZh?=
 =?utf-8?B?SytaMFlYSGN2U25mV093eExwcnFaMkNBS0dMWEZPT28wcGhtWE5ubE5lWFU3?=
 =?utf-8?B?TDlmNVQ2eXQyNmVxRmxPOTFZeW41MlA0eHJvamFVSGJqR2VSYUZLUkVKTXhK?=
 =?utf-8?B?NUIzKzdsWFpodXhPenhrOXU4QjFTemFCTFZzbEUzY2QyQkRFV21CQlJqNGxX?=
 =?utf-8?B?eTRkZVEzZzFkdnRldWFKTmREUHA3WjBmN0pDSjkzN2llQ2U4emQ4ME5XTkZ5?=
 =?utf-8?B?c2tWZjk4cHNFNEp4YlM0U0JyTm90ekRRdXdjSmR4RkhINW12UE1ycjBIcDdW?=
 =?utf-8?B?bWNRN0dtblVNTkJoSXROZkNJdSticHcvSURwTWxYSlZVR0NjOGV1d09qYTla?=
 =?utf-8?B?dTZwaFpjZ1BEczczWWdiVEpqQmtKcHZvRDY0VDYvU2dpNjByQVRreGZjenBv?=
 =?utf-8?B?K3cxSGtEZ3Q2cEFsd0d6WTFaODhxeVQ5QkozSjB5Vkxmc3owUVRvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E79F73D5DA1F5145BE9FD3E7B780AEAA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P3mW/GTQGppPmO4sUR4Mhjhw/XLt9f5YpUZZqyPP4DjrtNIZmn/NSfp3n8mik4f9y/ti8cayCFjzb63I+0AA8xSdd9St6lE1QUd5/jMl1dDPTJBfu/x6x2/GsxIURSlGOyIc7qN6heVwv5Od7SK6UgFYtcw9ErN7UXLhy1EXLCICR0ZnNCG7dYZetAAwAtOpxhl8hmxv81QFnLei+40ZoiQIJbMEzRbXm8oJiu/5b5LJRBz6y3ddT84yG3Q8Kosrt7omWe8WcaRQIVgXpMF5CCFfnle7pUQ7Vx/hW6qqhAATTnrQIDQHcJSPanX857DUdWRMWTCE67iKKG8gm33U3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17a722d-3f47-4879-4ee7-08dec2d86023
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 07:59:31.4596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NRXgwobvqUnlsJbFIiCS/TGMOVHdJmK3r95d6O2O35C68aogNslaa4l4vn8sHRGbn6FNyuNSUBa2HuFKYQ6LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF31CEE2CEC
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBrdm1fYXJjaF9hc3luY19wYWdlX3Jl
YWR5KCkgImRvd24iIGluIG1tdS5jIHNvDQo+IHRoYXQgaXQgbGl2ZXMgYmVsb3cga3ZtX3RkcF9w
YWdlX2ZhdWx0KCkuICBUaGlzIHdpbGwgYWxsb3cgbW92aW5nDQo+IGt2bV9tbXVfZG9fcGFnZV9m
YXVsdCgpIGludG8gbW11LmMgd2l0aG91dCBuZWVkaW5nIGEgZm9yd2FyZCBkZWNsYXJhdGlvbi4N
Cj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQoNClJldmlld2VkLWJ5
OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
