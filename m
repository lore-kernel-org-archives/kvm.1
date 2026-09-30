Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075A46C83E;
	Wed, 30 Sep 2026 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809120; cv=fail; b=g5aTpXMI98aRx3mDPVaqJi86bAIr2yYNBFxDlnGlzJ9lh0iO+WeeOG5PxFpwzUMl1jMBwFZYdbV/K6o6xLzsm0Am18xFtNXM8FMFGCT2jXpygnp3tk/NTRUAnezlss5VvvVFHcKGEwWQvI9Y/m4krZliN5Ay7qof87f+iGPFNDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809120; c=relaxed/simple;
	bh=Ctp+No8ZtRyUpeO27G7cx6eSG+NpUfl3Hn6+MnVy3Ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KkBNKgZwE/USo6uZs24qVzK3Fajy+m5NWX50SsmF2AarbujZ5MbZ/jvAMC8EdTEssPDy+7o7ffeJQI1sjeq9nkjgrBIo4H7KU7VlcCdt3jxPG0/iwPfRveaW9LrKzxoR7AQ7dYS1PseQ4ATD69BcV/jmh4gRNIEUCZL3hjLCrj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1JCizSV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1JCizSV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790809117; x=1822345117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ctp+No8ZtRyUpeO27G7cx6eSG+NpUfl3Hn6+MnVy3Ho=;
  b=g1JCizSVGoX+U1+OfLwtql/Q0iQYaGwW9NfX9PU7TTlgirpbE0Zas0MH
   CoH9UFdg/QkUmP3LHELfHSN5UsVHeWaAlp117TqEEn/l5oSo9AEEnaFFg
   H4xZsPKMxskNgvbma9ChesUzItkvdTj4TVLtMt3tLz34m5mcCskzpE3CB
   DVOoAF5eGYXiIOVLro2dbm5Bm+RUEucKmTWWSexS1JxDOAzGFcUE8iV5Z
   dX0h186r/nr5qimgm4Jox8rE09kMc2v3011iaKC4nmPB0KkBbwXy7Wo6X
   bKvm3Q6uvrb6s2PdtNLacB+xy3TnP20INFM+p6gGLcgMveYbT8GJjUiya
   A==;
X-CSE-ConnectionGUID: qwNvDozESKiYB6/ZT+/QRg==
X-CSE-MsgGUID: 68ps0+VnTbKwHbCZMZOFpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94272518"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94272518"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:58:35 -0700
X-CSE-ConnectionGUID: uhJe+HktQHO8VenRTotY5A==
X-CSE-MsgGUID: X574rmVyTrmFpYTnDR6bTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="275374238"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 15:58:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 15:58:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 15:58:34 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 15:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhM5KPpXsTxbOLqzPQP/yBwpom3rDQhXFbvuOO9r+XexVdyMdk3DUmz9v7GLocfuyh6Ik2O0bQ45cHheD4I1Q1QxYOW9T4CJByNyABVAR2ZxMstk2wy8VvAn40cW1gmM3V2eaiBKD+W6BIOLhTmMfVVROrmdTKj6otNzWFUZZh+9lUE5cc6uudaXx9uF0nI41L3VkEuL3Kz/dRAvvp//+ee5RxoVUw4DRglAksGqgrkkPGqd0GqgidxjS9ZNhWn76ZO+pu7WAmyt4qrziGlILLxZvSWTA+jObQaIZigvIjQR15akRudLyqdHE0O/D2fFXTsnd6z+JofPFE25asiprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ctp+No8ZtRyUpeO27G7cx6eSG+NpUfl3Hn6+MnVy3Ho=;
 b=iC3Q0wVwmRodWLix9FTtOevv3I5UimOxql4/b3BqYbsILJyoo7aZgJDX7Kw25K9LygwRIDGfelfC+Rwhii+dz31uoeaQhmEhTsYaSNlmnIMHTOocs11J6JggkuWc3pIJyztMjXX4w6kGy9/GXVMyhrPxlq1NyPY8OkTrt0thSm2uIV1PDDy50NVGHftGydiPr7DZCA1v7oGyvsmpFH73Es9bHU+Irc3TecCXQ3UGmq6M38og8ANbJd1y2o+h7DVzJdmkwLzALD+IX+B4inH224NUVhzae913egdQABKAQrJJAH1DMPZgwNIrnrqG5kL40TLQzRGE26vo1CRc/TPq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA1PR11MB7822.namprd11.prod.outlook.com (2603:10b6:208:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 22:58:25 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 30 Sep 2026
 22:58:23 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v6 4/6] virt: tdx-guest: Add a helper for the Quote buffer
 size
Thread-Topic: [PATCH v6 4/6] virt: tdx-guest: Add a helper for the Quote
 buffer size
Thread-Index: AQHdUMfMMdIN81NTlUyUWnuGMUIJqLbnsHyAgAAKoYCAAAG2gA==
Date: Wed, 30 Sep 2026 22:58:23 +0000
Message-ID: <48d1cf213815b3b6db48773606ac67b1df299ed9.camel@intel.com>
References: <20260930103739.2851980-1-peter.fang@intel.com>
	 <20260930103739.2851980-5-peter.fang@intel.com>
	 <007f5865912a9fb40c0e3a1ca9b7bb36d8af9794.camel@intel.com>
	 <ar2Sn1ZiDQdygPPn@intel.com>
In-Reply-To: <ar2Sn1ZiDQdygPPn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA1PR11MB7822:EE_
x-ms-office365-filtering-correlation-id: c9f35d27-045b-45d0-2c9a-08df1f4654a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|38070700021|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: k1f2yqBLJkM9AYcZEJipHEveXfHDtDXDUqcWxjFD12n9hssBixGuWDQDo6hoFD2aPGo+3XJCci2Pa+nLmHuoTmFsnctBty7Y+9uzFsCMSqlb2MjYU897hsA68lWVoE/w7JMmoO3WZvWjfHes+D/b5S1mfFkcbY9CkBTQwToxB0l3QCLrEaMhyLjYEj4HYCsYfJmAcW+3+h5KnULNrUQqZ2ra7kfm2wO/73stqmytskv+HauykpfB0ak0VnHjMK54sQZyEPQn+aiWatMYR1zEhVSjiJclx76QHq8Jdqb1FuVLZzM2yLm6iUUqKT9XOOFmffPlVDFC7VIL2O8SmGCTPUT8wCzCWPmbVTXRNF+WrCOuRhifmn4LkIs4Ufn6v06mLdb9FWYujjBi3bYfXdXXbcKg7u9gWlUtPfEk/GJRgUEYpP3yoIGZIDtnE8TIx7Oq3pTq8Gl+Ik6DsRwM74dYeJbGmypsIs+Un2QkYU+c//Yxr9atQF5L3GhihiU2txW1JT0CvJ6I3eGdVfi9GD0Hnqq7/W9eEZGkUg4zF2UI+3Lh3b/fi40oneUmQYRi7oXCG6JdPBnYjbW7iRlClr9L02uyPVWDb5r6OZUQ/ia1FBsozq3xh7Rhol84xRSMMjIvOH6f1NEh7PeXzd+5694gw2/FMFHSQIJzi3r/D39KLdwdPk16hhK3aPvH60ZeE1MN8vRi6jBe8a8g/Lw4vo1inbKqA5fpf0M0ogcpR5QSwPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmtQTnMxRTFGMTlCSjFYaitaRUxXODU0d3JiN2VuUkdaMWxvUU1hZ0czN2Zo?=
 =?utf-8?B?a3ZaZ3BQK3dqRGhNTmNURHg2ekd3NnZOYzljTkR6a1g0OGZBMDVqaDlzSy94?=
 =?utf-8?B?aC85OEVKekFxQzZXT1NqUmQxaitNMmpVemhmYmN1TWVzU3RXYmFEd3FWbHBn?=
 =?utf-8?B?WnVLTzFIdW5ENy9QMmNNamx6V0JsSDE3S3AybC90ZjlVa1RhSTZyQml1a2tR?=
 =?utf-8?B?MkRMb1ZSTE9idjd3MStzRnlBZjZ3cEdEbEthcTNteXVIWldjQXY3Q0hXU05L?=
 =?utf-8?B?T3lBNXZpTEZyT1ZId2VCdXhMNDBYUi9OeGlvNlhHQnVUbDNuRzdHd1RLdDkx?=
 =?utf-8?B?WnBUY2pjV0ZaSjJqdWNlZDA2MWx2blF2c2lRa2Q2dEtJcldSNXJEa3hBUHUx?=
 =?utf-8?B?L21vbThaQWtDdk5sUW5YK25LWVNucEhHODl6NEpkMEE4TlJsdlh1Qzk2NGsz?=
 =?utf-8?B?cU5OWE5OTit2MkhNbW92WE53RHQ3dC9OaVZqQnhlQjh1VzZvVWlhTktJUDlP?=
 =?utf-8?B?eHJYNzhINk1EcDh0R01kczg3elZreVl3SzVaT1Y2d0M5U2FSeE4zVVk4Vk12?=
 =?utf-8?B?QmhyQWdJK256QllvUEJNRS9LaXozZzNiekcwU3oxRnZuMXRKRCtQZ3Mwajgx?=
 =?utf-8?B?TnNNR3dVY2JCdENRQzJFWWRhSUZYYnlNYklSYi9aUlBlYjdxY0ZlMDNTek81?=
 =?utf-8?B?NnFNOE5CVXhNV0FuOWVNMVQ5bStVOUhKNkM1YVJqa1FZaS9xMFUwZFlzSllj?=
 =?utf-8?B?dHFiSHFMUHd6RHF6UlJNTk1ONGxqWHNuOHFVbUgxbVZLYW5aaml3RFhtNFBs?=
 =?utf-8?B?TzREOEFZZnJhMGU0R3dmclpSSkQzVkFIZEJPelFvL3liaDFPWTRmZVUzUm5G?=
 =?utf-8?B?NWJXS3YydkswTGRobFU2VW5RR2dBeHFrUE83NlUxR3dEcVRnS1lZT1FheEFh?=
 =?utf-8?B?dmpYclcyaC9BUmpROHh0SEV6TlMyeVhvM3R5QnM1bGZaamFxTndqNHM4QWg1?=
 =?utf-8?B?NDNMMFlGeVdhME4wLzZwWEFYWTl3MCszZDcxWmxRT1lJSWxFL2NqNDg1VUxS?=
 =?utf-8?B?M1FDRDNkbGc4S0w5RzZ0ZkphVFZnYXVSbjhUeGRWQ1N5TDF4V1YrUmNNSkh1?=
 =?utf-8?B?SU1CVXQvc2t2YmdpZFN5UTZpd2tSMlE2d012MUVXMDdXaHJZdmVhdjlDTnNt?=
 =?utf-8?B?eUk1Q0lJajgrSWk1YlFjdzB4YjhiQlhlMk8yRU0zS0FiT09HU1QzL1JkclFw?=
 =?utf-8?B?bkxUL0hvQ09DZmlCaHUxT0JiVHRPYmpwY0k3aHVUOW5NT0ZIKzlEMThjekRp?=
 =?utf-8?B?S0M3K0dwQlBOWVdjZXlPbTFMekYvYk1LTmlwZDNnYUpxT21rVC8weEx2N29p?=
 =?utf-8?B?dVJ5Ymx2RllPZG1ua1ZjRE05VDdDRUhmaWVhTkY2bWVjQ2NFMStwZSt4YXZ4?=
 =?utf-8?B?Q0ZtVERYN25DOEhRYmNnMjFqQzJzWFo3ekVwTGkzOGwvdElBa0x0OGFydnhw?=
 =?utf-8?B?UmxhemdmcFllSm9Jd09YMURIT2FnVC9tUEJkUldaSDNlK3N3SUlyelc4bUpy?=
 =?utf-8?B?MnBBQTlxZlFUNVF3WW43bWFnMG9IamFhYzhnSGZSYS9UdnpweGtUTlRZdnN1?=
 =?utf-8?B?aDYyM3VaTDNLT016YWgvS3ZUaHhqOGtKWXR0RjhRTDZhcm9GcjBnQ21pVnc1?=
 =?utf-8?B?SUVDblgyNXlMOHBhMExjZUZiQTc5Rnlka1g3UmdiaGU0WTlhZjNLcGJYNzBF?=
 =?utf-8?B?SHBKYVpOS0g5MjUwbFZtWnRJQlArcHoxWlhmQWg1L2NaWDZhSXpHRnVwSTdQ?=
 =?utf-8?B?TXVVNlF6dEpXZkNFRVA1QzJPcHhmdFRGYUdaRWEwWUNqUFJvSEpmNmIvdjFD?=
 =?utf-8?B?djh5cUtkdjRUQ2xIWThRZEk0YWJRWkk3aUhmR2NxS0w0R3diM2JjKzRCa0E1?=
 =?utf-8?B?Y2tWQnd2K2R1Yk8vMTE0OTVSRzZweXVoWURxRTlzRnNmV1VINTJlTTRDZzFu?=
 =?utf-8?B?Y21YWWgwVTFMNGozb0E1cWFlYXJXWU4rTVBMRzNIclQyOER1bzRDc0daUEMz?=
 =?utf-8?B?YXBxRFRUTlpFY0VyVkFxVDRuekl3K2c1cFAwYTdNaWlrZXRaV2FmMVhRUjEw?=
 =?utf-8?B?TUh4NWE4QktNQ3RrUGRFeW94NkVlenIyWHF0UGo5ZHg0eDhRWm82Y05QYmFl?=
 =?utf-8?B?d09CSTVxSFVYSC9sZmFSQkxubkdtSUkycFRXa0p2T0taVVRRZEp6Wmh4V0FO?=
 =?utf-8?B?SE43MlZock5xWktGRXdPNU1UTFpvTmpVVGZPcUJSaHdNb1dtRnhMNERrNGUy?=
 =?utf-8?B?ZS90akdURFZEOEFTNDIweS9QaklDa2hIRm96ODF5bERXclY1dEhEZWozUTMw?=
 =?utf-8?Q?lDthESdw/+0TwGpM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38597D1ECF78D74E9EDEB655F2794D63@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lIYSiL0KiKbo0U9z+OQGomCyj4DjM7Ms9SM1akI/uZJq9nskHv349vWPUYDI1ZJ4dtdMR4viX9EQ/AikR8ReVYXa/53XRLpiU19EgKvcHK6wOnoJ4Bkwqt1oeK8EUJnoejqPWksPfJmGLU5VAURdCeBBIrTKZ6CQ+a3X/crpDYa7iRlN371IGwSGVU/cYp++I7SFIgwAXf4NjoXUDr45jEopW6OYTDh0u1gj6MUSEV9JEAbkFq7M8kb1XaRFx6bgP4QSAp6S/TpfkGBlSL8CSGpQawRkF2FGy3b0jMWsR9dD5fnIaTPcp8qXVtZMXwYhfnLd3rmroQM7tx6MVu8aGg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f35d27-045b-45d0-2c9a-08df1f4654a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 22:58:23.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjyM+ZX/pwX+08UTGv4MwoDsTDeI7gl3t8frTT0jTzj8nCNjyPvEuxsuXKsY04qmS8S/++jBR+hgVjBCjdP4ts2y17Hx5RNz5Y1xVT5dzRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7822
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDE1OjUyIC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBJ
J20gb2sgbW92aW5nIHRoaXMgdG8gcGF0Y2ggNi4gSSdtIGEgYml0IGNvbmNlcm5lZCBpdCB3b3Vs
ZCBtYWtlIHBhdGNoIDYNCj4gbG9vayBsaWtlIGRvaW5nIHR3byB0aGluZ3MgYXQgb25jZSwgYmVj
YXVzZSBEYXZlIGFza2VkIGZvciB0aGUgZmVhdHVyZQ0KPiBpdHNlbGYgdG8gYmUgY29udGFpbmVk
IGluIGEgc2luZ2xlIHBhdGNoLiBEbyB5b3Ugc3RpbGwgdGhpbmsgcHV0dGluZyBpdA0KPiBoZXJl
IGlzIHRvbyB3ZWFrPw0KDQpNYXliZSB3ZSBjYW4gZ2V0IGhpbSB0byB0YWtlIGEgbG9vayBhdCBp
dCBhdCB0aGlzIHBvaW50LiBJIGRvbid0IHdhbnQgYSByZXNwaW4NCnRoYXQganVzdCBnZXRzIGNo
YW5nZXMgcmV2ZXJ0ZWQuDQo=
