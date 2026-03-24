Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB363A1A54;
	Tue, 24 Mar 2026 03:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774324124; cv=fail; b=auhRjmaGgKUjZX+vPOXkl6eo6U3FmiUsJ/h3kae0sYA3JX5JDMRExzpBEFN9AHFOYHXnZZhSrRcdPCtPxqUUTm18Yc5DrQRKp7s8bZ0zJFckoUX81Uh3IbnFKTWlr7vt8pPYZdwOHEmlXIXSmEAy8uzSVAc+CV9V2vILgbzxb6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774324124; c=relaxed/simple;
	bh=47QmlEuP92oi3TCPr0Eytjiz4Yb0uARvdBSZyTerHck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZ6KWJYaQ6HnnlO4myh5sn+E53YxdYPbtDCzuE2pdC2YYHDqtiN/M3GEChOLKSAjX6uLHvLH2YKMMz77SLdStaxfsCop6dKdyaP7nH/xk+fpJuBfvvm61kKfzOI7qo8bsw2eSDwwtoKPNPcY9ZQV+CLGA2nt861NTFAP0pqHtHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=namg2q0t; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="namg2q0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774324122; x=1805860122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=47QmlEuP92oi3TCPr0Eytjiz4Yb0uARvdBSZyTerHck=;
  b=namg2q0tYHyKXddkwsh8TjLBUi0RsTK1AAq7C2+kUWqEjUkRXA7l6OWL
   +aXim/dxkrPMm5PWx4KdeUx7xgufsBTF/2ebNwTVo15fF9FqaYQLaEbu/
   ZMOyu325+WiB/q9IUIK4+pkyfDDEfgtFOcI6hG1y9goImv++Ua8gQLJna
   iqFHuMW5LAVqYtZAxoTbLyYzsOF1cFBx5iUJRYNJBiUIWnL3p4qhdtEoD
   6sqhsLqIdDOS1XynQ06JucQPmB4RZbazOFNcSncSE0imqVv+sqt9QILGd
   uI7PnZ5kJ26Afg2vSes0MCB/blfZNSjIlp2DHVedYTjwOUL8Aj0Q1rqIo
   g==;
X-CSE-ConnectionGUID: 73WwapeRQ2mhBuRfpBMM6A==
X-CSE-MsgGUID: GrD0ej/3QHmGoT67zhmkbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75404687"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75404687"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 20:48:41 -0700
X-CSE-ConnectionGUID: rNhhASfxT1qtOPnVSgExUg==
X-CSE-MsgGUID: Dd7cpt84R+6xAokNn3DTYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="219806887"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 20:48:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 20:48:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 20:48:40 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 20:48:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4FO+laodcjYdorp6QmQwWAkgA7maked/7rS8llkw0oEuGTmEeisdtyzDhcbUliQMwdprHTSa88+H7QqWFWkuKJfUlXpQBkDI0NFIj//W7mtPbjLlUIgobta4SceQIm4jWyNAla1w1orgSy5PAGyfpVxs8N9/G7DxAU1M4Y0+bagk0Mn9X34/tXxMqkrpRrPXBd/n2Zu9n1yTR3MGdSm7pRNMSTEAuMWzF448njt+yp6WklJTjBEnNreYEe5GlDYGcjDFLEULA6qKFcSrU/NrDIDoFg39aryBP977Sh+hsRdXfwDnMu6pK0IdEZWNzbBEtx1n9Hg3asrKhi6IgoZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47QmlEuP92oi3TCPr0Eytjiz4Yb0uARvdBSZyTerHck=;
 b=d15Ld619FumBWFWvjzrnysplpdw4losjSn43bJGKlmQBe1/BDkk3M+r+LCNEkKXr5T51iqvxWaGvYHA16AGYPbFxVxMm2ZHOuLOwAz6PrpkgjkI3L84aR4htYLAVsU2Hrg239SS+wSu8JYfDto9PaBMc3eUuxwoa1C4ego+m8Fi3vgaipxe71SmVB48XNNnqmgde8ta5P840ArDJb2aYmk+fpRQCBTkRYovkg+pOyhvZ1SbW+67r2bFDSSd7sJxODfBh0JvKiWN4+zjj3K0y7LuCQtmfhEwerVK0fPqxG11ePrBHeD82AWoRHWbuHRNIYbLeqNTNI+nBgUf4gRXUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Tue, 24 Mar
 2026 03:48:37 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 03:48:37 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "amit.shah@amd.com" <amit.shah@amd.com>, "Kohler, Jon" <jon@nutanix.com>,
	"seanjc@google.com" <seanjc@google.com>, "mtosatti@redhat.com"
	<mtosatti@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>
Subject: Re: [PATCH 03/22] KVM: x86/mmu: adjust MMIO generation bit allocation
 and allowed mask
Thread-Topic: [PATCH 03/22] KVM: x86/mmu: adjust MMIO generation bit
 allocation and allowed mask
Thread-Index: AQHcuMcM9z8scQBb70yYMaoV+er1RbW9EJ2A
Date: Tue, 24 Mar 2026 03:48:36 +0000
Message-ID: <0bd8c0720a618b15ccf7e76a4b34e89eb4315c00.camel@intel.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
	 <20260321000931.1947084-4-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-4-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA0PR11MB7752:EE_
x-ms-office365-filtering-correlation-id: a9fec001-77b3-481f-c994-08de89583ad8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Y00W9pn8WJxnMswSFFJEP8a31Tsu13AxeAfRG9tyfRPB9Xm3ObUhF7Yn5w3E3B6M3gCtd0pYhBdZiJ0uDtgsia9rgTMrCopAk/V7SCoBNwhF5wbN379D7AdPBsy4FoBccIe0/20U+bMLI+uT2PCJU0k7/qu2bImZtU2GoC9VRphWONAs29tR4ysB27ViMM8OPad90XmG1FoWrCXMYgSqeocMayOpU/EMsmqqwiRaWwO2Docf5bNQKGtGHpaiN1mbi0OUTwPDMbRGUztXJc4iNnSJrXq+jivpINZYDyqgYRyjnuoWMfWbN2tj8Dou+Dl65n/aaKPF6REFrQuPUGWE1ZUSdfrY8kdgPHdojCINPeFjo/6uhmLkEu496E9R8mTO1pZBf+JRh+n0saFv5xxWqD/jN0AtKV6PumgGJaJflYMJbmW1RKdCJanRA2Zn6vcq8LJsu2PeEje+ATnbxwQFYiDYJELW+dHoA/rujfio+9/nDgrooGCXuCb4+2Eh3RYV/GqLW5QTGxhtyv7CV+C76ubyDO6AsHNhKZfSTF6mPWS6SkXjJ8xgU+1qgF/aN+RLsDHmxM2VcWFNe2Vkj9pWqFqQdrCy3tri/6s1mpaWfrawMY2pR+aXr+CvhyfN0fvmO/YpSjpOfu3e9yuFhn6vjfgDb5I2bMhXPqEVvn7LG0lX6RPfY/e4CuFv5QIHjlHTFTuhZvIlSby/e2DFYO77CU2fkHkIN0i7/TKDnEkJO2amjzjCj6vsBp7dIXZlEseB17OS3NeTTAMvn+Khf6MCbqn3OjxT5hC+LjrlyUoANa4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1hteEFIRGsybkJVWVZOSFZvMDMwR09TblpwajdmMUNFZmlIOTkyYm82MS9Y?=
 =?utf-8?B?SzZlMFRJNXJDQjdhNHcrYWlObXBybTlKeVFabHNrSDBGeTFIZXdZVUhlQUVw?=
 =?utf-8?B?UkQvOHlueUVXWlNtMWhPbkdPTTlwUGxPSm93VGhFLzgrQ3JZakVPMWV1aXBx?=
 =?utf-8?B?WmsrelRLZ1cwL2I3WURnL1pNbkpDZWkxM1NtK1F5RHRUajBMSnYrdGxKTDlh?=
 =?utf-8?B?QjNYMXM5V1c4bU9TWWU5WG15ejNOWEpMRkxSRThiTkRJQzQ3cmdZOUtnU0RV?=
 =?utf-8?B?bFA5RUhJdk9wMGxTdXpVeFF4a3AxNGFXNEhsNElQZ0lTRXVubTIvNm9mSENL?=
 =?utf-8?B?ekpJbUxYWEFrQ0RzN0grOXl1TEphOTFaL3ZVQlJsZWZ2NWhtQlU0aHRwMHhE?=
 =?utf-8?B?WGNpU1kvTlptejdQVGtERXZPa2dOR002dHNub1RxTjZqOXkwa2tjSHZGSmZj?=
 =?utf-8?B?djJTU0ZIN0pkZUlHRDc2RU5jUVdpeHhvSlNrMmdtS3EwVFBBTWZzazF1QzB2?=
 =?utf-8?B?K09NZTIxK3VsQnpHb3FEcVZMdXU0clhPckJ2M2dQR0lFZVBzR2ZseUVYQ3l4?=
 =?utf-8?B?dU1SZkwzRUZNeUhaL2pQVUlCeTUvVWNKay9BczJnbFhIYmd2WGd5Mi85bXg2?=
 =?utf-8?B?eGdRL0ttYTBVWVhwVEFZREptOEszTngyWU5pS3IzdHl1WUR0YUoyNXVoR3dU?=
 =?utf-8?B?N0wrWjN1K3FMU0I1TTFzT3BBSzRqbXRMUld6aUxKTFB4SFg0bmwweWFZc1dL?=
 =?utf-8?B?Z2pOeGhoNmlZTHM2TURlZGMyUGZab29xdVBpbUNDNW93K3RhNHVTVThuMjVn?=
 =?utf-8?B?Zit4UFN0aVpvZ0dVTC9UY2Q0SWE3dndodUpYOVAzS2Vub0JWL2JMaE5XRVY2?=
 =?utf-8?B?Y1pEVVNpR0dnZmx2b2IrakVDeUtDTWRFeUlocEhwV2ZKbHduZ0tDSUw1L3Ux?=
 =?utf-8?B?dGU1enB3NWkxUC82TWdqaGdySjNUc0RCaVRWN0Y1U1M5V0dVTUVkV1lHSmdD?=
 =?utf-8?B?cHJacWhybmN4RVk3TE9NejFSMkNaV0U0dllFRmFsUnZmNzRGRXd0aTFQdTdu?=
 =?utf-8?B?UDQzVTUyNU4vSGU3YVhTRFQzTXhLdG1iRzJtZ3JWWHlkNEYwUlF1TU00ZlJK?=
 =?utf-8?B?N0JpL05jbUhmQkp1WTdSMjN2d1FvelFPTDJLSkd6K09NYS95VTFzYkhrQjlw?=
 =?utf-8?B?NFV0TS9nNFhkaGpLdU84VXhZMDZmOU93VEJkZ2JHeWpwc3M5a25FVFh5SmFp?=
 =?utf-8?B?MkhjRlJCemlSUnNNVjVlQnNQejVMcUVyem1oSC90SGFwWEUwREJvaU84TFpY?=
 =?utf-8?B?elUrc2g1SnNobzJqeVFxczBDUVVUZmhMSGREWUxRaHdRMko3eXhFa2liTzZR?=
 =?utf-8?B?cEZKZ2VMQ3g4VVNxaHJpQU5rbTlsYjV1TnZvdVJudzNYYkwzOS9DbnE0U2c5?=
 =?utf-8?B?MHd6YndqeHE5eGJBeWE3NVY5UmdyQ0tkc3diWWRkUmlsR1czOFlXWWF5U2tL?=
 =?utf-8?B?ZXBWbDBLNGRUKzU1RkVNRnhSdGFVNTVDRG0zVGhPazhnV2lFSVljVVRDbDlE?=
 =?utf-8?B?S090YnpWdVNWNnhuZnNrWFJvZU5xUWNFMmhTcTErSjFHZndvTTlEcTQra0tk?=
 =?utf-8?B?a09rL1huNmIzM2thdjZJdVRiTkQ1RHFNVmQ2Yks1eTlRMi9aMW96QWhPZFJP?=
 =?utf-8?B?bkFlN2FoRlJ2aWR1Y0tMeU1hTDdBN3ZDdFJ0ZG9zRUljWTRoQWpNVStZQXVL?=
 =?utf-8?B?QjNGUE0xV2R6SGtaMUZtUWdSWFlJbkR5bGg4NHBQeEFFaWNlREg3ejFzS1g5?=
 =?utf-8?B?VE9qOUM3c0J1SkpOMGFDTmE4SXE3cFh3byt3djBMZjVnRXRwa3lFekxZYkNh?=
 =?utf-8?B?ZE5YL0FCbzVyL0hVV1BnNVp4NW5nbnRIS0duZVcrcDVKd3pLR2Jtb1hYZVQ0?=
 =?utf-8?B?K0xZY25YV09pMTJhZDJmN1BrTjRWeGhjN1haQ3VtRFc2Zmprd3NVUEx2ZkdF?=
 =?utf-8?B?dC9jekUrQ0lxZmxpK2FhcE5UVUpaa1JORkpDb0hxQnBYL2dQVVphdm90OXpz?=
 =?utf-8?B?aHhPVWpZV1dqdElqYmRoYUlFYXFqZUEvZC9JbGhjUWhRMEtjZTRrWHkrMFRT?=
 =?utf-8?B?bzhYTjA5cy8rcHVjWjdJRFgxK3NqaUxYYVNJUEpmdXhsTFhydVJ5M1kxY2hi?=
 =?utf-8?B?U05SL1ozL1NTdVdVK2l0b1pQSWJWSkxEMHJDOW9pOWlOWElJL2VMdVVvUG9J?=
 =?utf-8?B?QVE0RjdwdzhnemlacXFrY011QklVTnBQSWVGa2FJN0ZOdnhTZFZzSTZ2d2hu?=
 =?utf-8?B?VUtaZ2UrTHZOalFNUng0Q2ZSbGVtR09jVzNQYmhrdDFqdEJVaHZXdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3E79E4C3560B74BA403E557DC80E791@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VIOfL6coG7/WNDS7jaQcXVDb3xEXZXvOrifDLhudizIs5qjSSV+juhSrnm1ZkvWtW0mt2TCf9oGIZKadljlrrcAi2bSDuVR7BGQeCqgdyigJyX7YDgFQrWunsw8JVoWzxBPVte302fZ1/ujr4gHHOgZbpcnpBtfNpBhnUeK+wrrm87aPvcn/ycAxWj9FtNSB8bRP9XewXEKMrAoiy/3hJrVQWvBEaxw4cENUSzGb7KkCL8jdcx32a3FB4GuDjY29bK0cXI6jePACiQKBwbvDzQgaJdy+s/5mHBrjWGSiXC8g5NWuAj4cBeZv2MWfnlmubWKprQCY5vyKxLUzZ7XmUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fec001-77b3-481f-c994-08de89583ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 03:48:37.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhGI8YwdamRP6Qr/hiO47VXG3XkbS0tclamMaG29PXhFmFtfFv/gcYuava1D+QTE3lG4piY75j/JpT/AskqYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7752
X-OriginatorOrg: intel.com

DQo+ICAvKg0KPiAtICogRHVlIHRvIGxpbWl0ZWQgc3BhY2UgaW4gUFRFcywgdGhlIE1NSU8gZ2Vu
ZXJhdGlvbiBpcyBhIDE5IGJpdCBzdWJzZXQgb2YNCj4gKyAqIER1ZSB0byBsaW1pdGVkIHNwYWNl
IGluIFBURXMsIHRoZSBNTUlPIGdlbmVyYXRpb24gaXMgYW4gMTggYml0IHN1YnNldCBvZg0KPiAg
ICogdGhlIG1lbXNsb3RzIGdlbmVyYXRpb24gYW5kIGlzIGRlcml2ZWQgYXMgZm9sbG93czoNCg0K
SXMgImEgLT4gYW4iIHVuaW50ZW50aW9uYWwgY2hhbmdlPw0KDQo+ICAgKg0KPiAtICogQml0cyAw
LTcgb2YgdGhlIE1NSU8gZ2VuZXJhdGlvbiBhcmUgcHJvcGFnYXRlZCB0byBzcHRlIGJpdHMgMy0x
MA0KPiAtICogQml0cyA4LTE4IG9mIHRoZSBNTUlPIGdlbmVyYXRpb24gYXJlIHByb3BhZ2F0ZWQg
dG8gc3B0ZSBiaXRzIDUyLTYyDQo+ICsgKiBCaXRzIDAtNiBvZiB0aGUgTU1JTyBnZW5lcmF0aW9u
IGFyZSBwcm9wYWdhdGVkIHRvIHNwdGUgYml0cyAzLTkNCj4gKyAqIEJpdHMgNy0xNyBvZiB0aGUg
TU1JTyBnZW5lcmF0aW9uIGFyZSBwcm9wYWdhdGVkIHRvIHNwdGUgYml0cyA1Mi02Mg0KPiAgICoN
Cj4gICAqIFRoZSBLVk1fTUVNU0xPVF9HRU5fVVBEQVRFX0lOX1BST0dSRVNTIGZsYWcgaXMgaW50
ZW50aW9uYWxseSBub3QgaW5jbHVkZWQgaW4NCj4gICAqIHRoZSBNTUlPIGdlbmVyYXRpb24gbnVt
YmVyLCBhcyBkb2luZyBzbyB3b3VsZCByZXF1aXJlIHN0ZWFsaW5nIGEgYml0IGZyb20NCj4gQEAg
LTExMSw3ICsxMTEsNyBAQCBzdGF0aWNfYXNzZXJ0KCEoRVBUX1NQVEVfTU1VX1dSSVRBQkxFICYg
U0hBRE9XX0FDQ19UUkFDS19TQVZFRF9NQVNLKSk7DQo+ICAgKi8NCj4gIA0KPiAgI2RlZmluZSBN
TUlPX1NQVEVfR0VOX0xPV19TVEFSVAkJMw0KPiAtI2RlZmluZSBNTUlPX1NQVEVfR0VOX0xPV19F
TkQJCTEwDQo+ICsjZGVmaW5lIE1NSU9fU1BURV9HRU5fTE9XX0VORAkJOQ0KPiAgDQo+ICAjZGVm
aW5lIE1NSU9fU1BURV9HRU5fSElHSF9TVEFSVAk1Mg0KPiAgI2RlZmluZSBNTUlPX1NQVEVfR0VO
X0hJR0hfRU5ECQk2Mg0KPiBAQCAtMTMzLDcgKzEzMyw4IEBAIHN0YXRpY19hc3NlcnQoIShTUFRF
X01NVV9QUkVTRU5UX01BU0sgJg0KPiAgICogYW5kIHNvIHRoZXkncmUgb2ZmLWxpbWl0cyBmb3Ig
Z2VuZXJhdGlvbjsgYWRkaXRpb25hbCBjaGVja3MgZW5zdXJlIHRoZSBtYXNrDQo+ICAgKiBkb2Vz
bid0IG92ZXJsYXAgbGVnYWwgUEEgYml0cyksIGFuZCBiaXQgNjMgKGNhcnZlZCBvdXQgZm9yIGZ1
dHVyZSB1c2FnZSkuDQo+ICAgKi8NCj4gLSNkZWZpbmUgU1BURV9NTUlPX0FMTE9XRURfTUFTSyAo
QklUX1VMTCg2MykgfCBHRU5NQVNLX1VMTCg1MSwgMTIpIHwgR0VOTUFTS19VTEwoMiwgMCkpDQo+
ICsjZGVmaW5lIFNQVEVfTU1JT19BTExPV0VEX01BU0sgKEJJVF9VTEwoNjMpIHwgR0VOTUFTS19V
TEwoNTEsIDEyKSB8IFwNCj4gKwkJCQlCSVRfVUxMKDEwKSB8IEdFTk1BU0tfVUxMKDIsIDApKQ0K
PiAgc3RhdGljX2Fzc2VydCghKFNQVEVfTU1JT19BTExPV0VEX01BU0sgJg0KPiAgCQkoU1BURV9N
TVVfUFJFU0VOVF9NQVNLIHwgTU1JT19TUFRFX0dFTl9MT1dfTUFTSyB8IE1NSU9fU1BURV9HRU5f
SElHSF9NQVNLKSkpOw0KPiAgDQo+IEBAIC0xNDEsNyArMTQyLDcgQEAgc3RhdGljX2Fzc2VydCgh
KFNQVEVfTU1JT19BTExPV0VEX01BU0sgJg0KPiAgI2RlZmluZSBNTUlPX1NQVEVfR0VOX0hJR0hf
QklUUwkJKE1NSU9fU1BURV9HRU5fSElHSF9FTkQgLSBNTUlPX1NQVEVfR0VOX0hJR0hfU1RBUlQg
KyAxKQ0KPiAgDQo+ICAvKiByZW1lbWJlciB0byBhZGp1c3QgdGhlIGNvbW1lbnQgYWJvdmUgYXMg
d2VsbCBpZiB5b3UgY2hhbmdlIHRoZXNlICovDQo+IC1zdGF0aWNfYXNzZXJ0KE1NSU9fU1BURV9H
RU5fTE9XX0JJVFMgPT0gOCAmJiBNTUlPX1NQVEVfR0VOX0hJR0hfQklUUyA9PSAxMSk7DQo+ICtz
dGF0aWNfYXNzZXJ0KE1NSU9fU1BURV9HRU5fTE9XX0JJVFMgPT0gNyAmJiBNTUlPX1NQVEVfR0VO
X0hJR0hfQklUUyA9PSAxMSk7DQo+ICANCj4gICNkZWZpbmUgTU1JT19TUFRFX0dFTl9MT1dfU0hJ
RlQJCShNTUlPX1NQVEVfR0VOX0xPV19TVEFSVCAtIDApDQo+ICAjZGVmaW5lIE1NSU9fU1BURV9H
RU5fSElHSF9TSElGVAkoTU1JT19TUFRFX0dFTl9ISUdIX1NUQVJUIC0gTU1JT19TUFRFX0dFTl9M
T1dfQklUUykNCg0KQmVzaWRlcyB0aGUgY2hhbmdlcyB0byBNTUlPX0dFTiwgdGhlIEZST1pFTl9T
UFRFIHNlZW1zIHRvIGhhdmUgYml0IDEwIHNldDoNCg0KICAgICNkZWZpbmUgRlJPWkVOX1NQVEUg
KFNIQURPV19OT05QUkVTRU5UX1ZBTFVFIHwgMHg1YTBVTEwpDQoNCldoZW4gTUJFQyBpcyBlbmFi
bGVkLCBJSVVDIHN1Y2ggU1BURSB3aWxsIGJlIHRyZWF0ZWQgYXMgcHJlc2VudCBieSBoYXJkd2Fy
ZQ0KaWYgQ1BVIHN1cHBvcnRzIGV4ZWN1dGlvbi1vbmx5IFNQVEUuDQoNCkFsc28sIHdoZW4gTUJF
QyBpcyBlbmFibGVkLCBwZXIgU0RNIGlmIENQVSBkb2Vzbid0IHN1cHBvcnQgZXhlY3V0aW9uLW9u
bHksDQphbiBTUFRFIHdpdGggYml0IDAgY2xlYXIgYnV0IHdpdGggYml0IDEwIHNldCB3aWxsIHRy
aWdnZXIgRVBUDQptaXNjb2ZpZ3VyYXRpb24sIHJhdGhlciB0aGFuIEVQVCB2aW9sYXRpb24uDQoN
ClNvIHNlZW1zIHdlIHNob3VsZCBleGNsdWRlIGJpdCAxMCBmcm9tIEZST1pFTl9TUFRFLg0KDQo=
