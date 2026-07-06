Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447A3C465;
	Mon,  6 Jul 2026 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783370847; cv=fail; b=bdIa2c6xSJAU2YpBnASyefnToZOVeHkhfL7G36ookYwDHW2v0lbS8K1CwgpTjNvgUIdIvNdSU4P6vvOOLiBVjZTxzBxFm7d1fonbv3r8CfzouQvWwVofvChKc6D9ynQH/pRm0K9xeKeRvl0Q/eq4c9bQPvuQpL+YKLtAw9ct0S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783370847; c=relaxed/simple;
	bh=Ypgs0mMWDXDD7CfyyIPDpxp5Nf4THs874VgoGPY0TmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mPGmTXCyj1TMurjRvWCbtY6b+MAVj5jSOaCP2nVTIklzD7Xm7FphkGqOFBlfp/QP1/hV6ZipiAhtnX+THbs5+VFsdRejCAAL0jFWfsRm5x+++Xrl5lQRL4lINv6qFMQlWGUWrlvyQ4MyoYOzc74ngR+AAKl32i+c60m8F6Q9lqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DicADr4q; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DicADr4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783370845; x=1814906845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ypgs0mMWDXDD7CfyyIPDpxp5Nf4THs874VgoGPY0TmY=;
  b=DicADr4qwziZ9aSIHQnSoE/clqIsoVHVyOnX5f4CFHdxDz/3i23VOpaO
   OFzDMSfXxZEIwIA+hJEZ+m5EMX8sPCKICb4QNdjxAWvN251GeP4D3xBVx
   xXxFG6LiMAj0/c1nDCvoqzU/gaxCNSu7c2qZyTmXMwHQIUFhL6nJyP+Be
   QhvyZHUfMRdW1H26PdfcsPPlFbUTbTZU2qoEgaG2WKF7TvdOiROdZyBjw
   Fk7Q1EHuHH+LWzDCxFIdMM6O3dm4YdFYfZr9Q2K9vwu8vURT99Fe0SsTV
   pVdfP4h3dHbgu+ERcuBiU5CVg2UlCMa4Ii7PwNjrxaxMoidtV+eugy8ZW
   Q==;
X-CSE-ConnectionGUID: qP45p8amQHe+hRncsGvLZg==
X-CSE-MsgGUID: Xr/wGkkNSVil/GTlA0+ewA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="109558161"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="109558161"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:47:24 -0700
X-CSE-ConnectionGUID: FTEa7TVBSGqkIGZBEzrlhg==
X-CSE-MsgGUID: k1EfZpkCQ4O1yuGn99guTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="249819257"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:47:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:47:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 13:47:23 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:47:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLLwdja19e/8FIDg2OCrZlz2TdaqOWmtP2GBmTpTb3jbo5mgA0rKdWB+ou38fFOBWqxDEJJhUdTLmS25DMxBtFChmIUedLIzs7tPAxIxz2Nc/jX0JVq1URlLwiHCwCqwKp/Pv31ZYhIXW3Wf+Pcz+gsMBA94QwYE0IiS3GPX90ugeQdPZDq1L0Y8OP/GLa/XSDLXQ/iWUyqibMP4w+ZT3Zu9kCmdlqEZeXVPdt/MH09j3y9eqXOtpSRMxzD0RMqvNyq9X1ERUxsYsvbsqw6X8/gkP3RereCdvTMkK3PZjz2qQAzXTq+ZI5wMxDL1R4WLDeNAnfpq5hUbry17vuPi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ypgs0mMWDXDD7CfyyIPDpxp5Nf4THs874VgoGPY0TmY=;
 b=egdWIi4z5gJzaiepzTAKk7pHvSVSwh2F8xIi36hQA6qcpltSINv0sW0zsg4FV4X/ge19SU2C7usEsYU33UvkuX/AzLIRhy8Ap6XzEtUnDQhehIkk4mBZ/NImsrnhAwR8Q3b3lJrK7vgD5CwRqAswU7WBPM57yKFCmcp7M9lx3YexRKr5wM+uv0Xb523rCmsey4HaiNDYhecJPIjW3PNTWeR2quMLr5I9Jbzs5FS1YR51rXO48q28jx8M5XxG5PzS09wTfGeDFt8prfhkYCJkXPt74/iDhAPz4zEcYDxU0qsoo4Dr+DMasnpNHbPFO6/31gCw/gV/EzAKSW8jn1mAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 20:47:18 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 20:47:18 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 09/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v6 09/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHc7LhX9RO+2pRq0U2tIIZKWA6Q3bZbWuoAgAXc6IA=
Date: Mon, 6 Jul 2026 20:47:18 +0000
Message-ID: <2bdcc07d98df66954b9508be537b6f6a7c9f88de.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-10-rick.p.edgecombe@intel.com>
	 <0c31fcdc-048c-4ff2-9e89-1ba112815c84@linux.intel.com>
In-Reply-To: <0c31fcdc-048c-4ff2-9e89-1ba112815c84@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB8775:EE_
x-ms-office365-filtering-correlation-id: 105b59fc-337c-4530-d1d1-08dedb9fc4c9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|7416014|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: nBdEy9rQUR0QQLt0giyoPoU1AznbugYt7Eci/W6xObBVNNarQpf6AHXo0mItAKCFSYES/pIl43lBQFIWA5FIygOeXeN3hAUny4KoPQi3ebDgIGJkKvGZeQvjNhdoMUYKxRWWiCFncaUUPfUEavKlEInMN6qlirZdylcQPL60i6BIbujIU+Fg+MNqt2SwUa08n8KThJr4itykN9RUZvb2AZjOOMDDpOKZz5s2nbGTUdWwoRHJcXztg9vnTohhCZ4D9J2FR9NldDaFbRWnclaGSw/8CbyTTZUggZhPN4dB3pYt1KtLKCj30m1cHPLIPPLsDK7uN7q9IcOq84vXUOIbMEGImRUHzI3f1gi6Ph7h2VAMr5iZ+T465DEu2F1s+Bj/lieNy5VJxzfXzONynyNyE5PtdRd46hZ6sXCL9/1tWAoxr+S6NVOscxbm9bGhC1i3TSnZJ5ZtbLxLhUtPNTelzR4CCp237cqdNn8YrZh8nY1kRJHE62MtOlY+ELlU22W01Md3rEdomFCsMCqH3Dgfv9i0OyEHwX3Bzd1aTqQT1wN8yg0CI8M72WY18MP8C26lhyQDM3Z+yr8mPfHUFp+cSCDu4I6znkmbwyatlnwpCuZervPLbG9ojVPSSFs/StxxYy79xOm6PbbNP7zwx8cLfyUH1tlDEqU7+HgYwionJNCTU+bcHoJDbF5tO8qa6Q58tMw8rezz6i8/j1yXDUyF7gF9XuGJ6LFYISnKwEk9R+Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(7416014)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uncyb2NrMmNYRFQ2YW5oUDYzQzF3Yk5WK2ZlUUhRY3Vma3I3cWJSbDV5YXFn?=
 =?utf-8?B?d2o4SDJ5dmtWUm1wdFJwajNrOVJrbU5hYW9IY1B6L0FTckhNNWJvVEFXN1V0?=
 =?utf-8?B?bmoxODRoUVVnaXJtU0JESk5Dd1hySFp0amNSK2JIUFJBdzJTSTJvMGpuM3ZH?=
 =?utf-8?B?QmRGTWZ1dkEwb0w2Zi9ieXN0VUJ4TUxtL3FLZGQ4MUppTldrTUFmWnl6aEJo?=
 =?utf-8?B?UWRBTDBMeTlQNEg4SFBnOUp6YnVaeUNjS3BVQnd3Tm0yWWdDSTJSYlFzWEU0?=
 =?utf-8?B?WlVIOTk0Sk03WVVYb05BOGUySmNkdlJPUEdxOUhveUovUlNvWkZYbWZQNjRV?=
 =?utf-8?B?S2RseGxwZkFSTUNVUUgxb21TRXhOZmtOdWJUaUhPbmZUZ2R6aDRPQml6L3VE?=
 =?utf-8?B?NnA2YTBhbnVxVHAxaDhSYjk1eVVvRStSdXZnY2M0UEdtb2x3eEcwV3hrVEVa?=
 =?utf-8?B?eUdxUWlNWTltOXVYcDVZYjdKSjg4bE9mYVgxWWhmaS9qZ0VTNHMxWUhRUFJI?=
 =?utf-8?B?cld5OWZtUzdlZ21VYm9NR25BUmFDeUJZTEJhZTZ6bG9aTXVTNzNGVVV4STk0?=
 =?utf-8?B?SGRGZEo0QmVqdDA1WUk1OTREVEhjUUEzMVpaUlUxWlJSbG9KQzM4RDd1aUpH?=
 =?utf-8?B?OXhVdmcyTDVqWTNKVWRpS3BycUxqYkxOSVdxWE93Y1RtVExUdFhGSUowSWta?=
 =?utf-8?B?TkVTYTFXNUpQQndFVEFTUjlESm9GRHNrMVVCR3FiV3pmSUdjaTE1UktVTWQ0?=
 =?utf-8?B?SGRKUTJnSU5WT1FxT3pMNWlWZ21jbEYxZTJadUViYU14V1d4RnJZL2syNTZq?=
 =?utf-8?B?eE42SDNUWUU1cEFiTGlGcHdmM2dkNi9jWmkrelBEMjJaYTRpMitJWlk3SUpl?=
 =?utf-8?B?T09OdytnZzk3Ly9XcHhTWnRPclc5ZWw3VVU5SWZQL2tiQXZqQXpSdi9qc2VK?=
 =?utf-8?B?ZjlBUDZ6a3pwWldKaGx2NXV6L1NnNlAxTW9DRnFEOWIzRmVZdCsvblgvdm1B?=
 =?utf-8?B?ODRvNVRxUEJITDZDNm1KZDQyeU9YRU1OTGtoa1RDNnhTaTZYQzdZN1V6aVRr?=
 =?utf-8?B?TFYwZ3NEdUFQS0h0am5SekY3ZmsybFljVTNoMlpaYmNreGc4QmhubFQrcEpN?=
 =?utf-8?B?YVRHcXVZZUdmQUlSUE04M2tUa1NDQ2NHVktDMkt1M3VIbzVMaDN2b0VIWThF?=
 =?utf-8?B?aE5obUsxREJYZ2x0R3QxckV1YWRJNktJMFNXcy8zbzFFTElTbUYxOXNZblM0?=
 =?utf-8?B?YzkvTFdaZEVURlhBWWJob0Z6cUpmVEo3dXNlSE5jQzhQeVdINE9Xb3ZsYzZh?=
 =?utf-8?B?djMwWkp1SGRjdmlvM0JUV012anMyRUlqM25peFRCTEtaZVBQS1RiOU94OEtt?=
 =?utf-8?B?MHZQM0wvY2lUU2w1dFFTS2tpU1c5b2VTaWN4L28rOFpPaDRXaHQyM1htVDd6?=
 =?utf-8?B?VHhneEMwNHlPRHgycnE0TEwzWldsMnErcURIUGhZWUxUZ20wYitWTWZkN3hW?=
 =?utf-8?B?SWtiZFE5Y1M0VjgzNHBKRHcyM005QTVvMWtrdnp3ckk3RTJkdTZ6WkJVUEpJ?=
 =?utf-8?B?ZHRBSkRRbGR4c1gwa2gwNFZDdFdYSkRMVFhjc0N5UlF0NWNSUC9Od2dlY2p3?=
 =?utf-8?B?RG54bGlzaExQZ2ZaWFZuWUxDSnJJU0E0Tyt4cmdCM0JWVDl0RExhbjhxVERu?=
 =?utf-8?B?UjFlNytFdTlCSzZGL01lQm1KU3Y1OWVyNUJTZEhqclBHUzB6YURVVDcxbVZr?=
 =?utf-8?B?Smt5eUhMRFhBQUNBOTRGc29wTkJKb1BqRUIxZE9HMTU0NWtTME9KaDdZZXdE?=
 =?utf-8?B?dFdESDhna2d5WU5QMElhVUNWR3gvaDkrUDFSQnQ0QWdobk1NdFloM3gwVHRQ?=
 =?utf-8?B?cHVZdGh6d29HVDNvdjhrTHJ4NnlhejBnOUVJUStrZkY4UmRxa1liVlZMSVpj?=
 =?utf-8?B?TUlnMlZ2emVqSGROUS8wOUpTdmJwejg3cmdhcmFRb1V5bGtWR1RPUmtkWlZN?=
 =?utf-8?B?WUtadGpaWHY1aEwwTGk5RUU1NzlkNy96dTdTZTVaclkyMlNibnRSRUU3OFo5?=
 =?utf-8?B?S2l0eTBzZVMyUW1aZHljSG5uQStEdlJNcEFSVVBCaXU2ZkRTb1dISE5FUVdW?=
 =?utf-8?B?dG9GTWJoTVVPQTNMVHREV0JFb0lZL2lUMnp6bTAvZnp0SklBOUhZRU1PTWUr?=
 =?utf-8?B?L1gvY3VlQmNIdlZGR3VSdGpTbjdZRXNjMXlPUTFZT0c4MlhjWkhrcFJxVS8w?=
 =?utf-8?B?SVU3Lzg4TjZDbmpTcHYxSmhkQ3hCN29md0xxUHRoeUdkMm80M3Jja3RYQlY1?=
 =?utf-8?B?ckJ4UFYxbGllVzNOUlk4R1dDVUUwVyt5Q0Q4U3ZtQjYxejRkV09mY2xpQzZo?=
 =?utf-8?Q?hm1tVsaWWBg5SkGM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6204D73E2A8D34D905BD6D1DF51BF29@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gB5MXEZ3C3yqfVMFUCHDMQNpRjVJRsHGTcROVKFdp0ICyGhy0jGOFU+zVlB5CkqAsgpxez0cA/tSiHWtAMhZqfe5t3pQEqOo8om+lzv75OSFRFQLZz3xQqP1XPAOlnRPa4puOb+enze0V6Wie1Fys+E89dlutSFoOXA6ExHqJqv1qaLjk5/FzQbF97b/y3SXV6Z/zH+I7utVE+UhL/9CTg2/2whMV3PrkWUDrcKauCM3OLqpg7MPl8sZFDOjahhVy3ZT1ghzuKu0tpNCwB7kBYJ27nAWFz+yIS/6bEloDLJm82UC0g2x8taTz2Zux0fq8BPmP8EYGe8rYpGd37EyZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105b59fc-337c-4530-d1d1-08dedb9fc4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 20:47:18.0790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+gl8KZcmTm2+Zj+5EUQQ8L7XGt9+SXFu2Pdc7cg5NbIACnaHI1nxw791MMGk6n3YZBuW8H5pwozTsa7KbeCH95n3pEfko3fI0riV6Bi7aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8775
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA3LTAzIGF0IDExOjE1ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
QEAgLTE2NjksMTYgKzE2ODMsMjkgQEAgc3RhdGljIHN0cnVjdCBwYWdlICp0ZHhfc3B0ZV90b19z
ZXB0X3B0KHN0cnVjdCBrdm0NCj4gPiAqa3ZtLCBnZm5fdCBnZm4sDQo+ID4gwqAgc3RhdGljIGlu
dCB0ZHhfc2VwdF9tYXBfbm9ubGVhZl9zcHRlKHN0cnVjdCBrdm0gKmt2bSwgZ2ZuX3QgZ2ZuLA0K
PiA+IMKgwqAJCQkJwqDCoMKgwqAgZW51bSBwZ19sZXZlbCBsZXZlbCwgdTY0IG5ld19zcHRlKQ0K
PiA+IMKgIHsNCj4gPiArCXN0cnVjdCBrdm1fdmNwdSAqdmNwdSA9IGt2bV9nZXRfcnVubmluZ192
Y3B1KCk7DQo+ID4gKwlzdHJ1Y3QgdmNwdV90ZHggKnRkeCA9IHRvX3RkeCh2Y3B1KTsNCj4gDQo+
IE5pdDoNCj4gSXMgaXQgYmV0dGVyIHRvIG1vdmUgdGhpcyBhZnRlciBjaGVja2luZyB2Y3B1IGlz
IG5vdCBOVUxMPw0KPiBBbHRob3VnaCB0ZHggaXMgbm90IGRlcmVmZXJlbmNlZCBpbiBiZXR3ZWVu
LCBpZiB2Y3B1IGlzIE5VTEwsDQo+IGl0IG1lYW5zIGNvbnRhaW5lcl9vZigpIGRvZXMgYXJpdGht
ZXRpYyB0byBhIE5VTEwgcG9pbnRlci4NCg0KUGVyc29uYWxseSBJJ20gb24gdGhlIGZlbmNlLiBJ
J20gZ29pbmcgdG8gbGVhdmUgaXQsIGJlY2F1c2UgU2VhbiBkaWQgaXQgdGhhdA0Kd2F5Og0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtLzIwMjYwMTI5MDExNTE3LjM1NDU4ODMtMjMtc2Vhbmpj
QGdvb2dsZS5jb20vDQo=
