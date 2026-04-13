Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E735E93C;
	Mon, 13 Apr 2026 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079726; cv=fail; b=ZYTneeHzr9DEqG9Ck5JsOqgXmsGQnooy4y4nGhDUchvN7sSxjoORiRQ+uknparJAX9TxiaVt893+f0LRPgGlYjndfMAo4Unj2LM3WqazAF3Hba3dVlXI1T7oAfVh0X75NyTw3vdOu0UKpTbssTxX3NtKMVUaEKufrgdFoTlOECs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079726; c=relaxed/simple;
	bh=ukKEzzjjBxT3QV6qU+g+kvGv0ybPimi6ItTWZ50SXSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B2pnJ+EsRmn0g6UymFzcbX+IiBcboOy03Ny7Gouy3MxGV83GLyet/Oqtk7SEHrnDdfi1WXFiwkMafzvVHc2Zz/In/zAvaqqXOY1oFK+4j00U6oDf/G2wkTnGFJ4zHEaSVudaQdJ9h8Np7LdTYswm55DOL9hqTSwGK05rbwdGIP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfzI8SKt; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfzI8SKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776079725; x=1807615725;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ukKEzzjjBxT3QV6qU+g+kvGv0ybPimi6ItTWZ50SXSc=;
  b=nfzI8SKtpxxv0IeEx5dwjvGWwLK4U9FNortQo3F+naqaLjIRnSUVoYe3
   eVUZ32XzaaVjkJDmW66xGzOVjFu7HEiqM6Ff9VB9Pie0nmk2t/2nm61S7
   R1XeuFVpj7C0x4L/RtIum2vyBtU7pJ58he7scCQeaQQd2NT39R4uSaqX6
   fZiAZtBegDhY7LcDWSUohjYXbSjC3/Z4C3dgSrwZWLED45CYCknyptFrK
   8kPTKelTfqTAN4hbA/R+achBocykd2AGGRt7tlOV0z6JW1zSuhHQWqI47
   2OcSC83Za5rxpdvFTJptI83oXyy8H6YdUGwbKPHZXeDo0T3fmjFYBwfHQ
   g==;
X-CSE-ConnectionGUID: Y6iB1cstSxeEh6DAdnCrtQ==
X-CSE-MsgGUID: XRXosEg1SeKFce6xQR+kqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80598725"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="80598725"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:28:45 -0700
X-CSE-ConnectionGUID: YBQPkRWiQImzd2//Ba/Luw==
X-CSE-MsgGUID: Y1prTeDgQg6xsM4ybxBzjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="226591873"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:28:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:28:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 04:28:43 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:28:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hb2bhkr6y9RuxPKnpgIO3ZBaVaZL7/NKf1hOK39X6sPiGLh4Wz/QPmsyM1wyFeVtgzMJQ2+bJuzl4omoTo0eFeUk9PCylrqPcZ4TbImRLF87zPA1QqUEYwP5F06c+DDcY8iLPWpjJb5wmXaUCu3rTGypUUBfQwNAuHLhmc6eIhGKcSt5dG1lKH/asKAvzVg5LfBjY1KjP5oyyIPh6o+Tjx9wCKbdyBtyet47RyHXg9SBFXQU48q5ciZ06GzHRyJU/kOKC1uGWlM3WNjoHVrNNgMwtQhv5R8/zSRMiMPTRsvvu2QlWTIyiTNlc3Kw+/GLzKU2UPtEcStE2Q+NonvufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukKEzzjjBxT3QV6qU+g+kvGv0ybPimi6ItTWZ50SXSc=;
 b=GpxRAyEGpc8yvHih2QIyiKMWTnO3SzEEHLqAAjzdxHcVrIeVLBpMlWMHucFmmEabhGOQeKdMWZcvg4iw3SBBn1wszO1nfTPl9u3OTJigTUn/g1IEhHW7Vyez4A6eCl1LHtOviNWwfnditaoTCAq/jjY6R4SxDhiBd7khwAgKD2k574wHCDqCYBw3w0g+KKicduX76XWol8Lid4QXpBK7WG7AgUZ3MjMO0YHThpbkXdlcpJodbHZFxt475h0O1saZjp7YFt0OzVUk2TKp+bDyzi2RYZ1DlnSYdVoczlUku/es4uqFVWtpi9KGHAqzB37QscV2ymJcStSd+U20aOIXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 11:28:36 +0000
Received: from BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee]) by BYAPR11MB2647.namprd11.prod.outlook.com
 ([fe80::32d7:4779:29d3:a1ee%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 11:28:36 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
Thread-Topic: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
Thread-Index: AQHcyHKA2qiN335YikKlMB8aHxcOdbXc4G2A
Date: Mon, 13 Apr 2026 11:28:36 +0000
Message-ID: <e6e82905e6b9b1637ccb640097e67d21793f5895.camel@intel.com>
References: <20260409224236.2021562-1-seanjc@google.com>
	 <20260409224236.2021562-6-seanjc@google.com>
In-Reply-To: <20260409224236.2021562-6-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2647:EE_|SA0PR11MB4671:EE_
x-ms-office365-filtering-correlation-id: f589564f-2ab7-4988-2729-08de994fcd68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: bRAIN927CUSUtGG2ARXxEquUeBzeOvz5UPo5Ji0izALNTJldpY+28rgS5ZvEkxPEL28y+uos0g+qP7nfQmrIW7V4lMUebg2ENIbmwV+qBdbB1VF7rgabPCaHouiMM4V5+zl0w5t4YaIlEBmC/elIQpUo3nrZO95Pzbkjee8n5Iu5UI+ptdncetR4x9j9idwztmmxpomj8ITPFS5oqA3K65XNlFDbmlBp3FAfQtNkICsl2W7cAmEI/eAe3yEWJ0zc66N4k8uxTktYBx1tPbW2pajRe6RMl6OyUS1RFf2LHooNy/SKWzP5fnyYlMI6qzNl3YHZEldf+o4wnE5Qp/DKsYu8lIInrjVQR7dgFfuZK7pZEK07YL6qPqG0lpMSQbB7LZLYC8MrDgxPm6d9k92FbVOduhZp11UU70aIzX4p5ayJ3WdARTNUcdb6Mn9qC65vO/sIWKS30TQn5KC696DT8dtpn4VqkPjOr2fbtB31Gc/x04aJmyyu0ldcfmrHQFYu/aYMjN1EJlVmWSBkLq0+XKS0rp2uksjfGBSssdYMnE8Yfv0Bj5/q4X0PwkF2FmQ8wZWri2+tw/TKEKGXXpLrw5jN8hrpAUL+eRq11qpcczRwv0nzg8kDs3zwTBSTy9DCmjAUDo3f7MTO1h/7HBz+3eTYLzSgHmYqhsaP0JEO7I0ZQITtMjHvl7OkRHrpM96F2/2s576h1NAcsC72QnVieXaIXEE5Mb58b5HUT7gEsXlA4N6fxA/iVsdKZOIFbpLloa/9b7txKvhFRg0xhQlVNcjgSZ3jWQo8lLjgdIXKCrU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2647.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkZBZ0FKWXNLUXBDN2tZVTRSWVoweVpHUEZnRWZYUGNKRzVIWm8rUFV5WWxt?=
 =?utf-8?B?K1o0WVJRODNlN1R0cmJZZmlvRGczVkdibjY1YUx1Q09Gb3g0cmdwUDNlZitR?=
 =?utf-8?B?cWtQc1B3dmlvNlFHKzg4a0I4aGM5V1NZSW83RmxBWDdObkFmMCtlWlFuZDRK?=
 =?utf-8?B?Z0Rqc20xUGxaZXlOTTZ6d3JxUVJuUE5MK3VyaGFvOWtVRWxtWFBnTVpxeFdF?=
 =?utf-8?B?ajJpTWpLL0dkMEd3VGRlU1NQR2pFYTZic0t3MDVocXkzWkl0VHdHQ3dwOUYr?=
 =?utf-8?B?VHNVZklOaVdDZzVyeDBadjVBSEhoeUhSSzlEb1lBNGY0aWkxdEREczQ2ajZ1?=
 =?utf-8?B?MC9VNkYrWWZsLzNnaDRhTjdlaytnOHoxL1BhUmx5empkZFBhK0J2eTdpK1A3?=
 =?utf-8?B?R3VESVVIS0RaUnJRMmx2YnR1cEg3QVZDTUkzVThWVlBOT3JNaXFvVVNacDN1?=
 =?utf-8?B?dkw1YUtXZ0dVU1AxWVBWd2pvNFhzSzRKYVFWazJMS0NBZ25sZjlmNm5xQVhK?=
 =?utf-8?B?QW94SGN6MDJWKytwYVJoOS82Z0ZiQTlqaVNUR2tmNlZsV0pmaUVwYngxTzlB?=
 =?utf-8?B?aHZGaHQrbHN6QStvTjVQd0d2NFFGdU5WWmdydDZsVHdXUzBFaHZuN2E1aURq?=
 =?utf-8?B?QzJJS2Z2bDE2OGNVL3lTM1ltTzdvN3RMUHA5YVFudFB5NlhLSGY4NEIvcFVE?=
 =?utf-8?B?VWNWL1p6R2pQQ2p0UjNadHZJN2toNSs5OUUrOTBlb3ZJOHRWSHpKWDdmcnRR?=
 =?utf-8?B?cTZWdldKYi9sWE1pUkczMVVrc3paQ0tiSGhhczJ0WGM3OFU2bTZMZkhiK1ZP?=
 =?utf-8?B?THc2ZmhZU0EyTlZyNjBzbnc1WnNqZVdYek9wdURScWNHT0RSQ2U2MXJuVmM0?=
 =?utf-8?B?OXVReWpMR3loRU5hZEcrVitjbTVkQURiYXgvMlRWV1ltVTJFWDV5RU9iREFx?=
 =?utf-8?B?Z3JUUzI5TkwvNHhKRUVUYjRJcm5XQXZWS1ZVaFhZeUpjUEN6dWRnSkpkR1ZZ?=
 =?utf-8?B?eXh5b0dHbDJ4Y1dIUUs3Tzg2R2lsUm9XUFhoLzFzWVM2SFlpem4ySEFCUkE4?=
 =?utf-8?B?cjdjZ3M0dWxSQzljNE92Y3hyRTBPcXpBMWFoL1l1L3ZRMzIzR01Nb3RFOEF6?=
 =?utf-8?B?ODVRWkIxanNaZW9HbGVsSWlPNFNaWnkrV2N2NXhxUmc4RzBiMWl5SU5mZ0pJ?=
 =?utf-8?B?emYvbk14T0VCM2UxeGlJeUJZSmRUNUpSb21yYkU5MUJNY2Y0aEtGRXgrd1hO?=
 =?utf-8?B?Wk9vOHQ2LzZxWVZSRDRwb3VxZnd1aWc4dm1yQWF4UTdkNGtpRm45NXpGR3Ur?=
 =?utf-8?B?Z042YlF5Y20zci9OOFR5VXh0YTVmM2NERkxNK2JEWmg3YU9LNWpIVlpnb0U4?=
 =?utf-8?B?N1dwWWxnNE5HZCtKY3Nla2lITVRGSVlVMmlSZWM3cmMvWXIveW12QzJEQUFl?=
 =?utf-8?B?NXR0TTVZMnF6WjByTDNhc0Q1bVlqQzIxK1l6WEd3UmlXb3VvWlUzRVJGMU0z?=
 =?utf-8?B?QXZKQ3FvNkQwMHBTTU94S0w3NUw0VEpkQ0JVeTd3OXV3NWlMR25hUGwwSG9q?=
 =?utf-8?B?R1ZqeE5ucWJxZjVWY0VFVksyOUhkaElmN0xIbXFPdzlRN3RzT0NROE9vR080?=
 =?utf-8?B?UjIvOTUxS1BER3g4L0N6L2hSN08wdkd0MDNwamVCMlJGWUlUZk0ybXVoN2ln?=
 =?utf-8?B?bmlVUEFSbWhNak9SeEN5UkxWNFlqVUxjTFdzWVJUZkFETFNGVjAzcE4vZGVG?=
 =?utf-8?B?MXBEbVUwbVA1dDBUeHZKQ1NLODMxTkdOT0JaQlhFSmQ0czhXK2tRbTFuOGxz?=
 =?utf-8?B?TlpRRDgyUWNXSDk4UGhaNnc4TmRBWWN5S050ODFpUE13L3FhcHBBTGNoQUZH?=
 =?utf-8?B?UmpiTzB1Z1pxbEs3OTFydTNCbHJsWlRNTGw1N1VHZzZrc2xhczVLSlAzMDAv?=
 =?utf-8?B?ZFRkeVcyYXhzRXk1eEw5OXJvMnJ0N0srdk5wWlRMaWk0TG1hNlpNS1Q5SXh5?=
 =?utf-8?B?MTdtcE8xZnNabDBqZWRCMXE5QTd4ZVUvQ28ra0c4ckdzTmVXcE5QQnk1M0VP?=
 =?utf-8?B?Q3BvdkpocWJPcHBHV0UxdGRVQURscXRCNUVxaVZOK0wzZ2ZBVnk3WEpRbWt1?=
 =?utf-8?B?OERxTUhkK01ZMWFUckZSUHlxZFBVcGNVUktlT0NmSVFJQXc4cGl3UHF3Y0hs?=
 =?utf-8?B?T1d3cEZtUGY2eDNtOERoYXFvL0t4ZVF1QTcwKzlqalhaQ3hIVzNyRjNpZW0y?=
 =?utf-8?B?TVp5Z3ZwWUFDUEdNMFNlWVNYTEJaUVNCYlRmZ0JJQXRSRVY0SndRczVFb3hh?=
 =?utf-8?B?bTNsaTJFbjdCWHVCZjJCWkVJK2o3RjM0QVdoMVRxKzdaTVJnRmNTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4A1B76258D70147A8CD9A22A65A5330@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gPi5Kp4C3PuqFPv0AYSofWWgcqGBGw2vhkPA67W6ATGj5PKs0z6y9bbNKG/O+so2Vw7y/XYe6QFI74dPEC0Wnkvye49GszXj0jf/ekyjc8BqqeaHsFnwg9laB0BQzY4IM4q61ZCfYE4aHJgc3a9miDWXGqDrz+lNKW5zE9lyK+Z16ncguogyeWRg4WEks+eWQz8JaiEFMwEATPNAR5ua+axLlOKpn5MR2juE4NHF/bmpcmV4isLSfbg+wzx2au7oqYpyPqC01uMlO0nvWvvhsdgwt9RT55Yixe61BVpL4F++quml+5vX/YXgUbpFWXYWR7gr1OGBZUW4dHE8XniBSw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2647.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f589564f-2ab7-4988-2729-08de994fcd68
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 11:28:36.0619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taBpWVz+RgRLrYuMPdBASKRk82ttHlKjdCf1c8jFYxWDnlGBMygAfPmlCqMWpBunviBlDsLwKyd0Y2uDn52QyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTA5IGF0IDE1OjQyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiAtI2RlZmluZSBURFhfUkVHU19BVkFJTF9TRVQJKEJJVF9VTEwoVkNQVV9SRUdfRVhJ
VF9JTkZPXzEpIHwgXA0KPiAtCQkJCSBCSVRfVUxMKFZDUFVfUkVHX0VYSVRfSU5GT18yKSB8IFwN
Cj4gLQkJCQkgQklUX1VMTChWQ1BVX1JFR1NfUkFYKSB8IFwNCj4gLQkJCQkgQklUX1VMTChWQ1BV
X1JFR1NfUkJYKSB8IFwNCj4gLQkJCQkgQklUX1VMTChWQ1BVX1JFR1NfUkNYKSB8IFwNCj4gLQkJ
CQkgQklUX1VMTChWQ1BVX1JFR1NfUkRYKSB8IFwNCj4gLQkJCQkgQklUX1VMTChWQ1BVX1JFR1Nf
UkJQKSB8IFwNCj4gLQkJCQkgQklUX1VMTChWQ1BVX1JFR1NfUlNJKSB8IFwNCj4gLQkJCQkgQklU
X1VMTChWQ1BVX1JFR1NfUkRJKSB8IFwNCj4gLQkJCQkgQklUX1VMTChWQ1BVX1JFR1NfUjgpIHwg
XA0KPiAtCQkJCSBCSVRfVUxMKFZDUFVfUkVHU19SOSkgfCBcDQo+IC0JCQkJIEJJVF9VTEwoVkNQ
VV9SRUdTX1IxMCkgfCBcDQo+IC0JCQkJIEJJVF9VTEwoVkNQVV9SRUdTX1IxMSkgfCBcDQo+IC0J
CQkJIEJJVF9VTEwoVkNQVV9SRUdTX1IxMikgfCBcDQo+IC0JCQkJIEJJVF9VTEwoVkNQVV9SRUdT
X1IxMykgfCBcDQo+IC0JCQkJIEJJVF9VTEwoVkNQVV9SRUdTX1IxNCkgfCBcDQo+IC0JCQkJIEJJ
VF9VTEwoVkNQVV9SRUdTX1IxNSkpDQo+ICsjZGVmaW5lIFREWF9SRUdTX0FWQUlMX1NFVAkoQklU
KFZDUFVfUkVHX0VYSVRfSU5GT18xKSB8IFwNCj4gKwkJCQkgQklUKFZDUFVfUkVHX0VYSVRfSU5G
T18yKSB8IFwNCj4gKwkJCQkgQklUKFZDUFVfUkVHU19SQVgpIHwgXA0KPiArCQkJCSBCSVQoVkNQ
VV9SRUdTX1JCWCkgfCBcDQo+ICsJCQkJIEJJVChWQ1BVX1JFR1NfUkNYKSB8IFwNCj4gKwkJCQkg
QklUKFZDUFVfUkVHU19SRFgpIHwgXA0KPiArCQkJCSBCSVQoVkNQVV9SRUdTX1JCUCkgfCBcDQo+
ICsJCQkJIEJJVChWQ1BVX1JFR1NfUlNJKSB8IFwNCj4gKwkJCQkgQklUKFZDUFVfUkVHU19SREkp
IHwgXA0KPiArCQkJCSBCSVQoVkNQVV9SRUdTX1I4KSB8IFwNCj4gKwkJCQkgQklUKFZDUFVfUkVH
U19SOSkgfCBcDQo+ICsJCQkJIEJJVChWQ1BVX1JFR1NfUjEwKSB8IFwNCj4gKwkJCQkgQklUKFZD
UFVfUkVHU19SMTEpIHwgXA0KPiArCQkJCSBCSVQoVkNQVV9SRUdTX1IxMikgfCBcDQo+ICsJCQkJ
IEJJVChWQ1BVX1JFR1NfUjEzKSB8IFwNCj4gKwkJCQkgQklUKFZDUFVfUkVHU19SMTQpIHwgXA0K
PiArCQkJCSBCSVQoVkNQVV9SRUdTX1IxNSkpDQo+IMKgDQoNCk5vdCByZWxhdGVkIHRvIHRoaXMg
c2VyaWVzLCBidXQgdGhpcyBtYWRlIG1lIGxvb2sgaW50byB3aGV0aGVyIHRoZXNlDQpyZWdpc3Rl
cnMgYXJlIHRydWx5IG5lZWRlZCB0byBiZSBzZXQgYXMgYXZhaWxhYmxlIGZvciBURFguDQoNCkZp
cnN0bHksIGFsbCB0aGUgbGlzdGVkIHJlZ2lzdGVycyBhcmUgbWFya2VkIGFzIGF2YWlsYWJsZSBp
bW1lZGlhdGVseSBhZnRlcg0KZXhpdGluZyBmcm9tIHRkaF92cF9lbnRlcigpLCBidXQgZXhjZXB0
IFZDUFVfUkVHX0VYSVRfSU5GT18xIGFuZA0KVkNQVV9SRUdfRVhJVF9JTkZPXzIgYXJlIGltbWVk
aWF0ZWx5IHNhdmVkIHRvIHRoZSBjb21tb24gJ3N0cnVjdCB2Y3B1X3Z0JywNCmFsbCBvdGhlciBH
UFJzIGFyZSBub3Qgc2F2ZWQgdG8gdmNwdS0+YXJjaC5yZWdzW10sIHdoaWNoIG1lYW5zIG1hcmtp
bmcgR1BScw0KYXZhaWxhYmxlIGltbWVkaWF0ZWx5IGRvZXNuJ3QgcXVpdGUgbWFrZSBzZW5zZS4N
Cg0KSW4gZmFjdCwgSUlVQyBvdGhlciB0aGFuIHdoZW4gdGhlIFREIGV4aXRzIHdpdGggVERWTUNB
TEwgb24gd2hpY2ggVEQgc2hhcmVzDQpjb3VwbGUgb2YgR1BScyB3aXRoIEtWTSwgS1ZNIGhhcyBu
byB3YXkgdG8gZ2V0IFREJ3MgR1BScy4gIFNvIHBlcmhhcHMgaXQNCm1ha2VzIG1vcmUgc2Vuc2Ug
aXMgdG8gbWFyayB0aGUgc2hhcmVkIEdQUnMgYXZhaWxhYmxlIHVwb24gVERWTUNBTEwuDQoNCkJ1
dCBldmVuIHRoYXQgZG9lcyBub3QgbWFrZSBzZW5zZSBmcm9tIEtWTSdzICJHUFIgYXZhaWxhYmxl
IiBwZXJzcGVjdGl2ZSwNCmJlY2F1c2UgVERWTUNBTEwgaGFzIGEgZGlmZmVyZW50IEFCSSBmcm9t
IEtWTSdzIGV4aXN0aW5nIGluZnJhc3RydWN0dXJlIGZvcg0KZS5nLiwgQ1BVSUQvTVNSIGVtdWxh
dGlvbi4gIEUuZy4sICBLVk0gdXNlcyBSQ1gvUkFYL1JEWCBmb3IgTVNSIGVtdWxhdGlvbiwNCmJ1
dCBURFZNQ0FMTDxNU1IuV1JJVEU+IHVzZXMgUjEyIGFuZCBSMTMgdG8gY29udmV5IE1TUiBpbmRl
eC92YWx1ZToNCg0KICAgICAgICBjYXNlIEVYSVRfUkVBU09OX01TUl9XUklURTogICAgICAgICAg
ICAgICAgIA0KICAgICAgICAgICAgICAgIGt2bV9yY3hfd3JpdGUodmNwdSwgdGR4LT52cF9lbnRl
cl9hcmdzLnIxMik7ICAgICAgICAgDQogICAgICAgICAgICAgICAga3ZtX3JheF93cml0ZSh2Y3B1
LCB0ZHgtPnZwX2VudGVyX2FyZ3MucjEzICYgLTF1KTsgICANCiAgICAgICAgICAgICAgICBrdm1f
cmR4X3dyaXRlKHZjcHUsIHRkeC0+dnBfZW50ZXJfYXJncy5yMTMgPj4gMzIpOw0KDQpTbyBJIHRo
aW5rIHRoZSBtb3N0IGFjY3VyYXRlIHdheSBpcyB0byBleHBsaWNpdGx5IG1hcmsgdGhlIHJlbGV2
YW50IEdQUnMNCmF2YWlsYWJsZSBmb3IgZWFjaCB0eXBlIG9mIFREVk1DQUxMLiBJIGFtIG5vdCBz
dXJlIHdoZXRoZXIgaXQncyB3b3J0aCB0byBkbw0KdGhvdWdoLCBiZWNhdXNlIEFGQUlDVCB0aGVy
ZSdzIG5vIHJlYWwgYnVnIGluIHRoZSBleGlzdGluZyBjb2RlLCBvdGhlciB0aGFuDQoibWFya2lu
ZyBHUFJzIG5vdCBpbiB2Y3B1LT5hcmNoLnJlZ3NbXSBhcyBhdmFpbGFibGUgbG9va3Mgd3Jvbmci
Lg0KDQpBIGxlc3MgaW52YXNpdmUgd2F5IGlzIHRvIG1hcmsgYWxsIHBvc3NpYmxlIEdQUnMgdGhh
dCBjYW4gYmUgdXNlZCBpbg0KVERWTUNBTEwgZW11bGF0aW9uIGF2YWlsYWJsZSBvbmNlIGFmdGVy
IFREIGV4aXRzLiAgQUZBSUNUIHRoZSBLVk0gaHlwZXJjYWxsDQp1c2VzIG1vc3QgR1BScyAoUkFY
L1JCWC9SQ1gvUkRYL1JTSSkgYW5kIGFsbCBvdGhlciBURFZNQ0FMTHMgb25seSB1c2UgYQ0Kc3Vi
c2V0LCBzbyBtYXliZSB3ZSBjYW4gcmVtb3ZlIG90aGVyIEdQUnMgZnJvbSB0aGUgYXZhaWxhYmxl
IGxpc3QgKHRoZSBkaWZmDQppbiBbKl0gcGFzc2VkIG15IHRlc3Qgb2YgYm9vdGluZy9kZXN0cm95
aW5nIFREKS4NCg0KQnVnIGFnYWluLCBub3Qgc3VyZSB3aGV0aGVyIGl0J3Mgd29ydGggZG9pbmcu
DQoNClsqXToNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdGR4LmMgYi9hcmNoL3g4
Ni9rdm0vdm14L3RkeC5jDQppbmRleCA4NWYyODM2M2U0Y2MuLjdiNGMxODJjMjJjZiAxMDA2NDQN
Ci0tLSBhL2FyY2gveDg2L2t2bS92bXgvdGR4LmMNCisrKyBiL2FyY2gveDg2L2t2bS92bXgvdGR4
LmMNCkBAIC0xMDE5LDE3ICsxMDE5LDcgQEAgc3RhdGljIGZhc3RwYXRoX3QgdGR4X2V4aXRfaGFu
ZGxlcnNfZmFzdHBhdGgoc3RydWN0DQprdm1fdmNwdSAqdmNwdSkNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVChWQ1BVX1JFR1NfUkJYKSB8IFwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVChWQ1BVX1JFR1NfUkNYKSB8IFwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVChWQ1BVX1JFR1NfUkRYKSB8IFwNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVChWQ1BVX1JFR1NfUkJQKSB8IFwNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVChWQ1BVX1JFR1NfUlNJKSB8IFwNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVChWQ1BVX1JFR1NfUkRJKSB8IFwNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVChWQ1BVX1JFR1NfUjgpIHwgXA0KLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQklUKFZDUFVfUkVHU19SOSkgfCBcDQotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCSVQoVkNQVV9SRUdTX1IxMCkgfCBcDQotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCSVQoVkNQVV9SRUdTX1IxMSkgfCBcDQotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCSVQoVkNQVV9SRUdTX1IxMikgfCBcDQotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCSVQoVkNQVV9SRUdTX1IxMykgfCBcDQotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCSVQoVkNQVV9SRUdTX1IxNCkgfCBcDQotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCSVQoVkNQVV9SRUdTX1IxNSkpDQorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBCSVQoVkNQVV9SRUdTX1JTSSkpDQo=
