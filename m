Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0747ECF2;
	Tue,  8 Sep 2026 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902151; cv=fail; b=A1HRCVfPAz7yjQdGxgP2ZPTbvMgzMjgdxusNJ7D+E21wa1L0F6Svv7xuUaAFWyi2bh/pqF4Pj14ATfozgeA2LYJvQDiWbUApVXdT0ntysvSn2CNPJtOw+rZGjFi/mQzsfrMrRnnEVfnka7l4jUW9fYd84rC1+ATyQR5vlbZ9gNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902151; c=relaxed/simple;
	bh=mzXpAinrU0b6s5WEuby1ikdVErPrKpPDKGiI2qh3RAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1jfI3w1eSYlJ/fE+HUtp9wQb8agriuz42kHarlNO+FIN/TK6XI/ifsNg5nW9TTEQoBuCSdfDuQPdbcQu1doyHtcPpa2/v5GOGDQcTls/s60H4EPk6T+qNBNUsZan+tjCRIFbDNdjC+4mZ+G5TXRBaOeIDK+xiBbNtlRLFUtNx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/Nt/jIt; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/Nt/jIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788902148; x=1820438148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mzXpAinrU0b6s5WEuby1ikdVErPrKpPDKGiI2qh3RAE=;
  b=a/Nt/jItXpg521OyPWsg5WTNQNkKyhjoYEno1tTk5Yrw86O7fdGSwFV8
   l24T1ikoI/TnC9HLruYRO+KLzOZcw6bRzoi3fc7W9/NcZV3jwZkoGPvSC
   xV1DWmT/Gd0dZEEL3zGviKCtEoMPQ2FKHTDwzrSbLXOdT0BhTe7eijjvE
   nO660l9WoOKUEC50x2ClBLggnZHeQmTRhQSRcjgvOOKLT8sqeAtEBt65F
   gcbnoxT19jqOmo6Mmo/wSt3aI/I41n+C0llH5iE5qClJNCfjAwg4TjW/v
   XbgONGJcaWr+asP+aabGfwr6AUC8LZbGzAW3fFO7fvQzuR9yxSyV7LBd5
   w==;
X-CSE-ConnectionGUID: m5moN+p0SOe26fJ+ocLXtw==
X-CSE-MsgGUID: TzoMyeT1SMyGFy1DaeUSUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="114857070"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="114857070"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 14:15:48 -0700
X-CSE-ConnectionGUID: F5hom8WfQbGw0Ax03Zvp+g==
X-CSE-MsgGUID: 2kSLqkpKTvGqu6Q34Rq4PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="267453723"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 14:15:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 14:15:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 14:15:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 14:15:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f94eqebDQUWn//C4y0qhtFcSuRNe3H66JL/3JMf0xhpL/28ZyZpGY2Kbr+8GEUPRNEMMD9Vl3tyo7/tj0Xq3WddN1Vghi6gRMNjpB+EkAo+89uNTmQuh2IKv06nvnwHMSSX5JJ52IIYiubuUDvbhUk6RrB9rIcU+lAPAet1Kg4d5CRFLH1Q03tyUdWs4iuF22jJtqEve0as5/4WynoJv7rZj1dNNmvoWxXH1XVO7cgaZq5ei9TyXZMQ1JbrXkAsQJOKtp2zs9KxvAgnDp47Vvnyu6wcxtdKAhrU+j/Mne3EI7+5x74f9qbzRaer6Ix5wK4sIrcPK4uxUyno9KgyhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzXpAinrU0b6s5WEuby1ikdVErPrKpPDKGiI2qh3RAE=;
 b=wpR9wpkpa6cL4bxduZwD4FxWt8a0g9cK8p6ldg8UGn+wJr7zE64L5RffkO+4HNd/AZ8u/g0hh9J425dxtLSiHBp/KNGl4KpE8Z0OyPuwsoroAJsjvpXkKNURMS4GyLBq3GlHfQyZ8tUd/JnRGi/F1erovjbBZigUmSnn0RBuw8w/b5gqyd2sctC1/qKMGrJJeBKgjmq8sq1nsPwqhk80LJuveCVzk7DUYRuNkyBoSILqLPf6q7QmzZr0sjH1Xi1T12WKO6rW41/y7qgW7syc7NA6RG86Tt5Zd+pGHMU10RgSnn8eat8Z7lJhm5iH7mwKNd8iYxpUVRdXlFxqgIt+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA4PR11MB8913.namprd11.prod.outlook.com (2603:10b6:208:565::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 21:15:40 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 21:15:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdNdIg5EuCH7XFUE6a3Q+aSzpVqra50omAgACnLQCAAPSngIAJ1GOA
Date: Tue, 8 Sep 2026 21:15:40 +0000
Message-ID: <294cd7315f729f3c9c35c1d5de111e6b3149b25f.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
	 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
	 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
	 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
In-Reply-To: <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA4PR11MB8913:EE_
x-ms-office365-filtering-correlation-id: f7b7e86c-0b61-4507-a53d-08df0dee55b8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: YGKwBb7DA8UTCxc+fitctfK0juZzcRj3Tyu2vbu7ZvpGWJpcTi9kCfaWA9xEsvLq2SWzjVViRVim3Y2YXxqTqXFNUzSBW7i3bIb9L0YzKUYJdzAhl7JE6znpd72nBKeUQ41IyghejCZ+rUrRxuOIW/7l+yITEw7XzZWuWFmlIZMFB4vR4jEGqJbP6v50OKzVU959wtGTnWTqvOgziA3gyhAke7/5koptCnuLesHVqs8ukeAk5f/alit2RCF+H3ZhopiKTxIoy5cpA3oBRwBcdyCZ3UyKinJUxYNF8IJXP+jjbn3W3j+PKKwzb1q0D/ci1hWATRm/c0hw97wd6z3UiqRuwTgFN+DDBw9RNWZQv/Duf2y1tQA0yC7NLdCZGp2vuf5czLL3JXFfsiOlXLcfvgpNDuoUp7G62XckN0bCgPHggfwXKFpK5ZsXiqBlMdW4mCPARkVjExuIi8DseobDmnRBANl4GdRpJWeMUQ8dpDLv4grfaJBXicy/ZK6E5EGsqBHB1XN+ui89YoDIrOJ9WvqMh8H8G1iiAxmieXrEjQmR5O6UmcTha6qLnneKfkmW/wlp+zmdKcCFHGoVu1KGd35Lj+h7tNADlITa9AATy97kulL7gFAeN7tCsj1aidv/HUjNCE/cpgPlt8/boMl/LBZXfi7RMxyoRf7tY0NTnGlpo9fi2GxAFfY807+HFi7mH0oog8XtsRvaA4+gCfLSuuDIACbFNw1tzf70b+pTSbg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3FvNENZNzdmNkhEa0QzZS9ZRUFVeWUwYWRNVDFvSEhXdlpuc2d2QnpES3cw?=
 =?utf-8?B?SmNjS2Z1Q3BnVEUyL0xvUTJkelRxRUFYdndMRzN6THlUSGRlQzkxSTlWYjVq?=
 =?utf-8?B?NzArR0RBY005RnVkSlpDaGJCSU5YVG1tQVJPTmtxN1JPa0NUNzRGT1kwTGtQ?=
 =?utf-8?B?NGFTOXl5a29kUVJmMGpEcCsvaC9sWERRUHlzd0dzSzBXak9SVzlrbmVROU1V?=
 =?utf-8?B?OU0rWkJFVVFHbmY1LytEMDRSaUdBdStINjFkQ29QZUo4VGk5R2ZyWjBUOXJW?=
 =?utf-8?B?cDVQb1hXRXZHMW5rTi9lTDlnK1VPSHFWUmhxaTJrYW8vZkJQcHMzN1pKSWtT?=
 =?utf-8?B?THFJa3Rwa3JNZWVUU2cvOUMrcU1jOFlJcDVzSitLQ2dScU5UdVRCejVKSGps?=
 =?utf-8?B?VG9QMnl4TU5zYjQxTGtQNVJnNUJMeDNidVlsOGxtbnJGYVV6UmpuMWZ0cVRC?=
 =?utf-8?B?U29WbXN2NUdZZWcvczYxU3JlQUJKZkh3RS9aT0xZUXFGQVc3RnVnUnlRTTJK?=
 =?utf-8?B?NjhGRUk3N0U5bWt4NXVBVEQrdUJIcWw1MjVaY1QvTWQrN1RtTnJHdkFUUk9Q?=
 =?utf-8?B?b3pvVmJndjJEcU9BTzdmc08vTGpmbkRvMUxEK1V2MXZxaWpRa2R0UjQxSkkx?=
 =?utf-8?B?MHJVOGJqejNoQ1JaWmV5bUowNGNHZU9IYTduLy9KSFZpeGxoMDZQczNRakNL?=
 =?utf-8?B?V3NGUmg4Tm9NUnZmMVdlUlZpQlNxMHpnamwzS0o4RkRYc0ZyU2djckZHcHBV?=
 =?utf-8?B?L0RZOC95alhpVzFWQlZsd1ZXamF2L1c5ZWNIc0RFdVJLNmlkQ0c4bERIb0FC?=
 =?utf-8?B?azByOE14TW5OQVBKbkR6bmxmZlhiNlk3bW1mWVRuN1c5RzhJNFVTendjU28w?=
 =?utf-8?B?WUtQaHNDN2pubjM2L3FlQTRFOGYvRHhNQzU2cm9iUVFrS09OQ3R1c2NsajdF?=
 =?utf-8?B?OU5wVk9BcExBRHZXWVNSUnBmblBkQU1FOWJISTRBZ1BpbXhNTjR3ektJckJq?=
 =?utf-8?B?QyswUTMvTnZnazFXMUM4Smk3RkFFMk9nS0Y5YWs2RkJXY29uaEZNODZpRTFF?=
 =?utf-8?B?c1ZIai9McGVRZ3hCK0tTS21xUWlDYmpuV241dW5SZ0RDeVUxUjRNTllFOVNn?=
 =?utf-8?B?TGhDTElwNFdlZDJ0aVhXTFdDSjdtZXdxSG5US2o1TlN2eEpqQ0F3ODNvbkZS?=
 =?utf-8?B?SThaV3JaUi9DLytleXgxaFhvRTVYVitoMFk3MDBuUEZudHhzQ2MwZjRnWGtP?=
 =?utf-8?B?TDN6RzNwN0xlM3NlaTc2S0lCb3V2a0tDVXpsYktzeU1maVpZUnE0cWNsS3My?=
 =?utf-8?B?OWFlbmpJbmxUczZLRjh5M1lsOFRaVUNDVUtLNXJFQzcvSUZsUXZGV0RuNXd0?=
 =?utf-8?B?UllISkdTaUN6NEFsbUIrUHVnWEEwVzdmaXphWVF5U3pleWlRUmFYdURQQk1B?=
 =?utf-8?B?cVQ0R3pnY0Fhb3MyM3BsNzhtTHI5YW5qbTFIZzkrR1Q2TzVQeUErQ3hMdW5i?=
 =?utf-8?B?UDY4VjhXUSs3TWRneUN0b0FJbDhNWDgvN1NqUzVGQi9NaE9lSXR4MGtqWWRz?=
 =?utf-8?B?M2hDSk5mZ2dacGxhK0VTUnFOdlJCNG1UeElubDRUVXJIMlF1bEZWMm9OTnJw?=
 =?utf-8?B?QmZ5eDErNmZ4MWFGc1dnVnV5bGhOUWNxMHBmUW1BR3QwWUFuWUMvcVZvdERQ?=
 =?utf-8?B?Q3c2YVJocUdNSS9QRFNMSmltSWYwNWRvaUVseTN6bjFVcDdMeFBjWW5uYURh?=
 =?utf-8?B?ZWxxQXB2Y2dQdm1CR0dlS0F3UnhiQlRqUlhFclRvamhMR2xTMzU5Kzh0dmw5?=
 =?utf-8?B?bHlxaHY1MVpEU1RJNVBkK1VSeDE5Q2dhWXk0bVNlRlBzYWhheTRYaDB1Y3cw?=
 =?utf-8?B?TnFkSEpheTBhQnlSZW9MME1tL1JHUW5abDJDQ0VpSStWZXk1cEJFQ202dnJW?=
 =?utf-8?B?TUFpd3QyV2lKcDhuZE43dlhxc0YzeFNpZzFacXBlTmx5SlAwa0hub2h3S2hX?=
 =?utf-8?B?SklvWXc0K0t6YWR0eFVXcGdWNkZsOVhJcHYrOWFGZFE3cmlWbUhSZENiWlhM?=
 =?utf-8?B?Z0Y0dmRZb3lUNlhET0M2YVdndWNMRFo2SC9ZVWIxNENCS0lYcCtxK28za2hp?=
 =?utf-8?B?eE1OTklRRGxLZncvWWxCT3RMQ0xhM09MNWhUb01uRlJmNHA4S3I3UG9qeitw?=
 =?utf-8?B?MjhLQ3M0RFVXOG5Jb05EV3FqOGRkTWh4SlduWnBNamVmditEdWFsKzU0aTFS?=
 =?utf-8?B?eTY3bWIwc3NmOUZPa0NqYnozaTAvWjVwREVqWW8zQWZqMGIwUXF4dWNoQjFF?=
 =?utf-8?B?TGJUNnZtTEFaQ0pIcmxYZUp0S3E3NVpNL0puUUppbmRNU1piQ251cHZ6K1VS?=
 =?utf-8?Q?NYx2HWKChsTCjPLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9561FE2FB96DE446BECE711FAFAFCA0E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MjxH9o458irMUz5ycHPftNQLN8rxtNdbE1R7XGYiInpTZ/b8Y9sEWATjfOghGiVm99jhoo9srIOcoaKgTpeyt0truIzaBo284S7cGf+z9XaFr/42kWWGwlndb1Cz3NI/FWjWyvoqp5/ZE7nW8p1LPuHIFXOWAgzV/x+mhdCdhCvr/CCEnv3CtizjSWu9BoBjJiAXRLk+1onSoXF7fviNh8Q2Zv72wlRDbc4iin1bERI2VSL1lItZclJ2K5VaJZdVT1DkkNIq1ALzr3f4+6zxR4Lm0tPaHd6Dg38Z52kMhVtqKgPK2xe23WGxuwW09R7EoRcHy+IUOC0uEhFtpHIUTA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b7e86c-0b61-4507-a53d-08df0dee55b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 21:15:40.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hq6raA/s+YueTDTGS3hwDLyZHqAYek5alIIc6NzCcpmK04Mr3hYt/t4lmwINAvouF6xo6Xth+03Iijzy7iVKszHdsc02yiM8DyEmOex3D1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8913
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDIzOjA5ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiB5
ZWFoLiBUaGlzIGNoYW5nZXMgS1ZNJ3MgYmVoYXZpb3IgYW5kIHdlIGRlZmluaXRlbHkgbmVlZCB0
byBjYWxsIGl0IG91dCwNCj4gYW5kIHByb3ZpZGUganVzdGlmaWNhdGlvbi4NCg0KQWdyZWVkLiBX
ZSBuZWVkIHRvIGNhbGwgb3V0IGNsZWFybHkgdGhlIHVBQkkgY2hhbmdlcy4gQnV0IHdlIGRvbid0
IG5lZWQgdG8gYmUNCnBhcmFub2lkIGlmIHRoZXJlIGlzIGEgcGF0aCB0byBmaXggaXQgaWYgd2Ug
Z2V0IGl0IHdyb25nLg0K
