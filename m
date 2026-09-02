Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEAD3002C8;
	Wed,  2 Sep 2026 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357211; cv=fail; b=MjacySrCpJnp+KTQf3d+FWS8E4PYdQcB9gIX9aS8aBsoZVRsCI8yo8ZYrjq7F02aYtVzuHSnPdU0dJHi6Gi+73IrY0q8YO6o+TffgU+51B1+jEGqsAwZ+vTs9a9bMrv59PNt6so51C7quMTDcpGloivkqLe/K5lWvoP6ju7zCzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357211; c=relaxed/simple;
	bh=6KllhpTI1Yqkr/LCwT4QeaMwCyV1CUYTZ7COOSHoSH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s97AdHYGH+yjeCl6sjN6A0VFIkfffG0BkSSynBRK5ZiQbL1Pqspz5EVwxn2q+xfu+JgBC+ss1og+U2Z83U0J55bFyMsTh6x36oFHd6iuyFSdtyqLLyBtaW/4CnZ9Q9tzj20LPkkwtzAxF2klesVGBW4f2uug3C659toy+lzcvpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBkyz5/S; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBkyz5/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788357210; x=1819893210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6KllhpTI1Yqkr/LCwT4QeaMwCyV1CUYTZ7COOSHoSH4=;
  b=XBkyz5/SNFM7maoJzt4Pv8QrHUlw0lKrlUuVD54+BocFqa/c3UDJPjtF
   WO2yUVYRblI1JLufEQjaKr1/ZZFhwrDOxguq7/DxGoO/Num9EactMcmHH
   h0TPof3NxYKKZd/1YkHxUA8tj4hK8GtTHJ69uw9v2MEzzcVik64QIEmkn
   qfesjHTB1RMZMsxghDtlORtNYEr7OyTCkDo5VWI/boDIdzMaKfOmwxLY4
   FFfh3ojkFjyVjfzYeEoXzO7JELHPDeQxv3/bCwzk95IzSsOlJM/MlBbq4
   strV7NOAGsFv0/lSOhpWx+uDSqXxjS+1jCZtQI5VdRrdjtMFVPuqRYCfD
   g==;
X-CSE-ConnectionGUID: nYLAnVJDQSScU6BM7Fn4Eg==
X-CSE-MsgGUID: fADXfEVaQ2SkjGlDi7EvEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99479764"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99479764"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:53:27 -0700
X-CSE-ConnectionGUID: 0aiYsyPZTPilPv6O+zMA2A==
X-CSE-MsgGUID: JQxlg/TpRVannU1gmW/knQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="272919353"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 06:53:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:53:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 06:53:26 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 06:53:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZhZfMVKJylU1yHLj7L10hjYfL8PfuDrJh1g1IIOfHZDKrafKS1ls3k5snvHj6OIu/Es/edryD0WrDwVvyeOak/ISYf1PQ7cs/3D9g6CZxJspbD5wNQ/J8882TecE/03ZZa9cjMwF4s2QTymwmLgCyaC2FLSeGaY+xtJv04TecsJDkHimrwlcFvAYeTi9GH20XicqpiiAMIFwvU6/+vStyV+2eE9RRojwo+N0nwkpZ81Wo1qoIPDrEzUC+WpOdAVEUT4JPC6/jDvaFsBDzw+LoHPwqLJ5b+il8H6DHqhyjQubijsREm8J59lnhyY+f8obgNuW/hJ65pcLYxMXCh78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KllhpTI1Yqkr/LCwT4QeaMwCyV1CUYTZ7COOSHoSH4=;
 b=tdv1zIOYinY/dO31qq3syyII+mO0U6SAAe9kCQJ0KOISi+ijs0kYoq0s5wyR+Y8gofIVAlHIYJbFAbqbrv21LybLzmGzk/DBItfSNWlL1oR9HPAGvJ/djmfwbJQYaMp4bNyKr6GbafHb9xF8SAnzBnPoJK8lC//QtdWkKsW1OazN+ipnFg+tt06+uTCrymImBBx3+FJoK8n3iEDAOhiGxfya3KbCagbrvWlWA4AuK2hqLg7ULnTCvsWVbt9eVzTbgJaevGc2ldwcw6Pr7Ce8fG56JL1Pt5XE5v1mNrYhWfAMccceLk3Diq69NQOAypHX0+Eu8tHde653/MiJAmPJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LVXPR11MB9777.namprd11.prod.outlook.com (2603:10b6:408:387::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:53:24 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 13:53:23 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Topic: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Index: AQHdNdIhqH6lArRWVEmiaZbi1C7mgLaySiAAgACCPACABrNBAIAAhwqAgAEZoACAAC2ygIAAB0AAgAAD+AA=
Date: Wed, 2 Sep 2026 13:53:23 +0000
Message-ID: <9920cbdf0f5f0114fba0e1eb2bb2931c249e9c41.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
	 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
	 <6f8f2c59-3336-4ed8-837f-57cb706ece30@intel.com>
	 <69c42183261acb4150961cabf6318b92765b6562.camel@intel.com>
	 <91c9e314-6b92-4f90-a2df-ed21104f84bc@intel.com>
	 <e4b9509c4e4b91277a30f88cb7ca76c8ba016997.camel@intel.com>
	 <f4594d40-cc15-41c8-99f1-2db590bba2ef@intel.com>
In-Reply-To: <f4594d40-cc15-41c8-99f1-2db590bba2ef@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LVXPR11MB9777:EE_
x-ms-office365-filtering-correlation-id: 24e0af15-c17f-4f30-e4ad-08df08f98e65
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|5023799004|11063799006|6133799003|18002099003|22082099003|56012099006|4143699003;
x-microsoft-antispam-message-info: j1ZZATaLyxlzEoOb+4GeYEB1oqJvruqRnIrmukmXMNByr43EQnZvkHMLWc2tN2T76EUiht1S9+uYpibZ47dyrPrf1ZUZpJPKAVyksxwu4B0jZlmB0ziq7F9EmUZbvQhJExhULC1i4lta59zQo1yJB7CrGX2DLD1XgIlUZO5Vq59VuCfF5wBcFdZFdTwPFZ6Uk6d47eMMzBuGLUy/9/SO4f8XN/3SuHndsGcgWhkpmNgp6cgMSeHnIZxSKUo1zB6sxlot4ppOVoDJOmptiHFOh76jWPiZtDt2p7cZfPtB6eozJBYpFRfEYNR3QXud8LifledPZY2l68L1Lg9HV/6Zft/6YuM9WSgVNx3/lpQvJEjGF0lbGT49k0knA4VDarT8TwQ0Ld3T/MyJMORW8JhccTxnN2Ra/3KTLSaIUFeUOdtGrS2WW+seajSwdolVWuFjiA4QcB4fjL1qZwMFlZzLXQIDE9wKAPDO5ORfzH/C2+ELCThN1SiSaS0yzII4DWSwvoUBhDLxN68/L80nm6mcyXBnLni+AZKwWwSVRkQ3hPerQnlPYrtdvED+83EzCpgwg/vn0Vq6H7Q82GDnZ9oaauZ/bvkxvqrkGH7HVRRPLCzveVLV347jV0Tt/2I2NYnlRHP+gbxXq8Hhi6PlNJ/qjp+bOw2IChVQywh8Z9oNQLCAOMac2vNRHqXWiIhYUius5imzAgxhK0O+LQgGqRBePw2EwKCnuNp6SvEWPk/yi60=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHgvMWRZSG52aEZTSUZST1NGb3NmV0N5UTBkdGxSREpRT1U0dURLMyttY3dC?=
 =?utf-8?B?STZzek5RSUdxQU5HaVpHQlNSM3dGU0VMdHpmMkREQTRJcWZuVm9GVnZZN1pB?=
 =?utf-8?B?N1U1REZPSVpVVmlUUTJCV3hvVmV5N093eFRmaUdxMTU5azZiSDJIYnMyeGc5?=
 =?utf-8?B?QXBtcnZ0T2dZeXcrUWNuMFZZSjVpek90M0ZTYjI4RDQ0VS9rVHpJWlRSR2VO?=
 =?utf-8?B?QmR2ZUFlY01pT0RRM0kvcnZSTnI0NVBOMlhLUXV0OHRnMkpqNnBlM0t0Yml6?=
 =?utf-8?B?NUpETGR2S1dheFlxZjU0RHAyMktmL3IrSURZRXJZNGpiV1p3N1ZTTHE5dEsy?=
 =?utf-8?B?WEpGd0tpZU92dVdNWVlPeHdabjluOEtQcU95NGRmdHJsVHB2NDFBaVBMcTF3?=
 =?utf-8?B?QlNKM2lMakdQSVIxcEtmdWxpMWFHaG56WXg3VExuTEZhM3g1bmdpZTZ5VkpG?=
 =?utf-8?B?QVhEQ25vM1YvallTeEVKRDJQUUFhRmlkd2pSL0FpOC9nZ1g5QUlTL0hGdU9L?=
 =?utf-8?B?K2xUZTY2ekhSWXBSS2ZNQkhHV05UMGdXa3BuOVhjYkZYY0g3THc3VnYzQVNj?=
 =?utf-8?B?ank3bllHLzFFaW8rRDF6K0FIY2dpTGlWaWkydElIQkJHRUZETjVlSHBvMUFt?=
 =?utf-8?B?OUFub0V0RkN0Y1JkSGtkOGV3YVQ0UGVBbjI5a2kwT0VCZ0pTV3JIcWNNT0lP?=
 =?utf-8?B?b29vNVFnVGw3UG14NlhkbDUxb2gybElYTFhmMGVoWWZhTlFPVWZGQmRON2Mv?=
 =?utf-8?B?anBDQWNHd0JPL3k4bGg2eXB0MkpIOUxqMDFZYnlXTWhhNE9aYkgxY2V6RkFk?=
 =?utf-8?B?bjZXTUFPZk41QkJLSU9hMmNjVGFRTys2L1BsdytsbTJBODZ4OXJRcmk0TVN0?=
 =?utf-8?B?MGhjdnpEdVR5V3JuNldxcWZ6azBMakJyd095VEJzVExsQ05hZVh6VmI3czE2?=
 =?utf-8?B?S1ByM0p3MTJrcERob3Nmelh2aXFUOGpvN0k2NVZuYTBRa0xQN3VtQ0gvbDNI?=
 =?utf-8?B?ekhPUWFiRlRBZENPRGNHMTJvU0Nia2ZJY1dtMXRXWWRZQnlXLy9jc3NhOEla?=
 =?utf-8?B?NVFuTGxLdGowaWc0QU52MW5vTTdUaEtHQXphMkxZLzhZbVE3RUEzK2FYV0Mv?=
 =?utf-8?B?MlZpMENndnUvemdmNlhpT0k0WDBQUUk0bE1YOU1UNGxJaElSczVhK0VvWmRH?=
 =?utf-8?B?THFyQkhDbzV3V1gvckhnRDhGT0JMQlVWQWNRRm02TlJjZTd6TTk5WS9YUUtI?=
 =?utf-8?B?NmJReUU5dEQycytINThPTEkzdmp3WDhqbkdqYytvWUl2dEN2dHpRbW1PSUdx?=
 =?utf-8?B?cE5laG1TU2xoU3Z3eW85K2ltbHNQYzBhQTdjQ3YxM29Bd1FZR0FKTGxVL1BN?=
 =?utf-8?B?Nk5WZkxWTCs5d2p6STE3ejBCc1c1N2N5dEJudi93aDdLaE1aQmFROWs5UnNO?=
 =?utf-8?B?S29qeE95a0l1WVZ0UDZiNURsbGd4WUZlL3ZPSE92blFQdHFuNzZyNmFpV0FT?=
 =?utf-8?B?bjRvajdoRExWOE11RUR3ejNaRmNZdkxIc0FwOCt4aU9pWTRzeDRwS2NJZWRO?=
 =?utf-8?B?SVE4VmlDZEdzd0dFaUtqZ1Y4LzNNcndDUEdkdmRZbDJlbHFjT3ZVQzNNUEZ3?=
 =?utf-8?B?TmtLWVllZTZSZHFJS2QwMWFiamNkaFVtVzlRMFBKRlVRQVpWdEU2SFRlWUY0?=
 =?utf-8?B?azZxUnIrb1gyVkNCdEJhQWZ4bFlKL3hWdkFGT3NiT0ZkTzVUV0RCbzFuRktN?=
 =?utf-8?B?ODExQUJVRmdJWm5uUE9rMG0zTGNmVDk0YkVzTEpKVHpYMzVhakYwdzc0T1Zn?=
 =?utf-8?B?R0tnSnRaL25oOEs3Z0NUTDZHZFR0c0tWS0czV3hySFphK0o5ck01UHp4aHA5?=
 =?utf-8?B?VlozT0EwQUFON3d5YWFvMFAvWVJyeGpvZ25Sb010dkNOMEc0ekFQeFduNldY?=
 =?utf-8?B?OERZbXJVdFpDSGhRdGppRDdZVVkvbFY1SHdwNWhyUmR5eHBodG8vbzFlbTdv?=
 =?utf-8?B?YnRVVmhPelJZZ3ptb0t5MCtDS3YzTG9KelJUVEp5elViOTRPRmxsRFM3VGV6?=
 =?utf-8?B?dFFBSGJWTHJWRzJ5WlNSclZSQi84NEZCZEM4Ui9yQnBIRnhRUUdCZU8vVFZv?=
 =?utf-8?B?V0R3eS9NbzY2ZDlBeCtrdmdMYjV3bGkyM05YUHZUelM2UmJsSGI3dUN0NDZQ?=
 =?utf-8?B?elNXUmNrUGpWQk5lQnNxdEFoNlFoYmJ6MG43U1luTTZUNGdGRjB2RExPUi9W?=
 =?utf-8?B?ZXJRZ3RTRi9Tb0ZsOFVYajhXZlZBc1l3UUFRc25qRDNpMXVJeWpzVlBmYUFR?=
 =?utf-8?B?WDA4ZHFsZ0lydldYWXFNbkplV2FDSnk3ZWZ1K3M5bEZ1Y1VYdkdhWnF5WUpW?=
 =?utf-8?Q?ENDDiu8XYCWFK9UM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFA5632585F2C147A3ACFAB81FE7E297@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: y7SzkQk2T3GjakGnEBOYoOu147NBKAiSYBLQ9VXhpkccOhIhgdgXG8LO47RfsmWBmUnvoVFDbBi5gaBCeZgs4vCdU6KGBeSBSx3Lpan+EJeswd7vhV4c2oC0q9Try/Pac2QmtlFgxGcBqk/v62zYcTMBuQx6E7ZP9G8VTj0oRojug4iWDPqSZBdyOll9wFwQ/kLx4XCRtqsk2xBR+JW2wkOm9qEK/24PT3AEU8VbNp5IK2S5uwY8GhqvHnzJ0ubFQbTtwXRl6dYKy+o6B9r153L3+0KeQtT/TGd+3PqHeshX+Mi+gjFwIXtI5y1OSgVWZ5eVMfKzGCJ3fDWp0PnZpw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e0af15-c17f-4f30-e4ad-08df08f98e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 13:53:23.7834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JpaLh+Xww1LotbP0ZxQpWxHpVL4DEy5HJhi5Ilf4x6hnymWdnm6IxR3dhiDRhp3YFgqEmmwU6ycaKojlH0JalSXZsWYeonG1EWVNAOVXPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9777
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDIxOjM5ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
IEkgZG9uJ3QgdGhpbmsgdGhleSBoYXZlIGFncmVlZCB0byBpdCB5ZXQgKEJpbmJpbj8pLCBidXQg
SSB0aGluayBpdCBtb3N0bHkNCj4gPiB3b3JrcyB0aGlzIHdheSBhbHJlYWR5LiBXaHkgZG8geW91
IHRoaW5rIGl0IGlzIGEgYnVyZGVuIG9uIFREWCBtb2R1bGUNCj4gPiBkZXZlbG9wZXJzPw0KPiAN
Cj4gQmVjYXVzZSBpdCBjYW4gYnJpbmcgY29uZnVzaW9uIHRvIFREWCBtb2R1bGUgZGV2ZWxvcGVy
cy4gVk1fRVhJVF9MT0FEX1hYWA0KPiBjb250cm9sIGlzIHVzZWQgYnkgU0VBTSBWTUNTIHRvIGxv
YWQgc3RhdGVzIGZvciBURFggbW9kdWxlIGV4ZWN1dGlvbiBjb250ZXh0Lg0KPiBBbmQgSSB0aGlu
ayBmb3IgbW9zdCBmZWF0dXJlcyBTRUFNIFZNQ1MgZG9lc24ndCBzZXQgaXQgKEkgZG9uJ3QgY2hl
Y2sgaXQNCj4gdGhvdWdoKS4NCj4gDQo+IFNFQU1DQUxMIGlzIGtpbmQgb2YgYSBWTSBleGl0LCBh
bmQgU0VBTVJFVCBpcyBraW5kIG9mIGEgVk0gZW50cnkuIFRvDQo+IGF1dG9tYXRpY2FsbHkgc2F2
ZSBhbmQgcmVzdG9yZSB0aGUgaG9zdCBzdGF0ZSwgd2hhdCBURFggbmVlZHMgYXJlDQo+IFZNX0VY
SVRfU0FWRV9YWFgsIFZNX0VOVFJZX0xPQURfWFhYLCBhbmQgdm1jcyBndWVzdCBzdGF0ZSBmb3Ig
WFhYLg0KDQpJJ2QgdGhpbmsgd2UgY291bGQgYXZvaWQgYWRkaW5nIG9wdGlvbnMgZm9yIGNvbmZp
Z3VyYXRpb24gdGhhdCB3b24ndCBiZSB1c2VkLiBJZg0Kd2UgZGlkIGhhdmUgYSBjbG9iYmVyIGNv
bnRyb2wgaW50ZXJmYWNlLCBtYXRjaGluZyBWTVggYml0cyBpcyBhbiBpbnRlcmVzdGluZw0KaWRl
YS4NCg0KSSdtIGEgYml0IHRvcm4gYmV0d2VlbiB3YW50aW5nIHRvIGZpeCB0aGUgYXJlYSBvbmNl
IGFuZCBmb3IgYWxsIHdpdGggYSBmdWxsDQpzb2x1dGlvbiwgYW5kIHdhbnRpbmcgdG8gZ2V0IHRo
aXMgaW5jcmVhc2luZ2x5IGJsb2NraW5nIENQVUlEIGJpdCBmaXggaW4uIEknbQ0KbGVhbmluZyB0
b3dhcmRzIGp1c3QgZG8gdGhlIGJpdCBmaWx0ZXJpbmcgYW5kIGdpdmUgdGhlIHNhdmUvcmVzdG9y
ZSBndWlkZWxpbmVzLg0KDQpUaGVuIHdlIGNhbiBkbyBhIHNhdmUvcmVzdG9yZSBjb250cm9sIGxh
dGVyIGlmIHdlIGZpbmQgdGhlIGd1aWRlbGluZXMgYXJlIG5vdA0Kc3VmZmljaWVudC4NCg0K
