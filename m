Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02494F5E0;
	Fri, 10 Jul 2026 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645511; cv=fail; b=F7FQEKd53kIiDVOs1p5JHGIlldXf+heKQqsDCmyKMc3ItIcw/9rqYTLzkkNpdxI6TKhj2frMucs/K5YmRiOE3mxVz4Tn8HK7RX1/nfK5FocWB9v5LFNuWEbMhdZuJO5aRz1Iaycv7kbHpp35lFmwY6MK9Pp1kWuxqlU+RKGluTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645511; c=relaxed/simple;
	bh=CYUo1fCI7naiSVMWZaI38HXWNFmdSOcNH/+YqGLpT9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JEBMsASN5MCunkm0LISwnhlvoMM6E2A1Zz7YnjV+pjVzbAKW5+aW46RKHywgEEQuMyev/dSzeZdZzeDLgY3JFSfI+9sgeKI5kCEySEzb0sVsBCcZQ8e3vrB4PBUx6v7iLkt602DxT9692TUXHSJ9ubUJ4Jv1XWVRZSRaDftvOK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbzrtBKj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbzrtBKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783645510; x=1815181510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CYUo1fCI7naiSVMWZaI38HXWNFmdSOcNH/+YqGLpT9I=;
  b=JbzrtBKj/bhFKFl4RfIkJOTRsjFCTGteSCqbMA+aNxPzbvxQKVqWQYR4
   ht4A5EJxHlpYdxarOBQOK0jMfj9xGSnP6mfuAOxn6DuGcrO4+NEoEA6Ii
   AyKbgYZ4pNf8nZVa0/y1ACUnWQ2NZx9bxkOF0pVPQ+dTjHGo6n3hj6Th1
   vwv9pp4VEvG0WjuheYn2hgFOFLnN9aqma8AWaJKdc7ucQ59NPQF6kDFP/
   +KsxciKw41NnwxXF4BjkRECmt0PQMlQalwd7CfOxixwuOO0MxrP3pb3sC
   U0a3KH7iVwHkXUgUhS6/uaa1VpaMMG37HWWfzHrNfu0AcktzeOSTPH6v+
   g==;
X-CSE-ConnectionGUID: 3AFK8vVJTfKoFq6KfNahKg==
X-CSE-MsgGUID: 2rIlF3ZORh2AFWMr9TSYzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101769473"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101769473"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 18:05:10 -0700
X-CSE-ConnectionGUID: 1+BeAy9oRsK8MW9RVcHxEA==
X-CSE-MsgGUID: xUlbe1YdT4alzc6hbThYag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="292941655"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 18:05:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 18:05:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 18:05:08 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 18:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEhizyOSzA5Ox232R3zDeOGC1G9Nk6j7SeofMwDZ3lRa9E5SUBurZfYxO1oBrVF1sVof/3mIbQusUBVPHIPqz0KDc58sGmi82bCHViCeEV1FOdfasLaDlrJuill+cACmTkSltg5hPjGUTgG4ZwvgRxR+T6kVf/S72XmqwRNd0LVRJvRTPSIHvHniqWtmdXsPauu8MatodgAn6m+5oxVsrWVs1Najwur9cT3fQazzs3rJmDMVOfsVogY85m8AkX+GEgMzlVpQRbrmLSfMgUmIwxF4gGXd3jjgzlYfRHVbcKTPmQ6FUoCngVEuhSlYjMckoHTvKqYgCyFoxIoT3zqw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYUo1fCI7naiSVMWZaI38HXWNFmdSOcNH/+YqGLpT9I=;
 b=NFwnc5YoOnHiflcMWay4mIPUm38LZ5yh3RuY6QwAv8OYbFw0qdGWAGRcWxz9xLsKzbFPGh8cT6+kvYxFaw6Vx3nWbJBT9SSvL2L3H5nekS8L0JBKfhGXydIq2gnsd/YGukKPF8GYdFZd0qfUCBp5OVlc19nUCOWRA37GxBvl/rFZfBxR7GUQRpPF2Nt4nKc0joWnvHzgi3LRfvtEUsRsAI4E+bUEqi2ySrzQ4uIuUxxBujYOCyWwtbt8ErkXbwrNEjE/RAxVND7S7Y+lgfY5AfvYNLYWVTrv774E752fA6FPFFKKhzqpMmgl4lXlxr1Am4wtFXHf+OC+4P1R1ulZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB7146.namprd11.prod.outlook.com (2603:10b6:510:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 10 Jul
 2026 01:04:57 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 01:04:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Thread-Topic: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
Thread-Index: AQHc7LhTEcr7wAnIiUS2NeuNOJCIabZjmrUAgAEL34CAACMSAIABbSaA
Date: Fri, 10 Jul 2026 01:04:57 +0000
Message-ID: <aa669cd125b9cbbddd9105cfcbade50f130405db.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-8-rick.p.edgecombe@intel.com>
	 <ak4UyN4fnIZasWM8@yzhao56-desk.sh.intel.com>
	 <f686c26073761302b699c7374b668c933b0452e8.camel@intel.com>
	 <ak8S6MiMkCEgJcP/@yzhao56-desk.sh.intel.com>
In-Reply-To: <ak8S6MiMkCEgJcP/@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB7146:EE_
x-ms-office365-filtering-correlation-id: 691294ad-0b59-485e-b4d7-08dede1f424f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|11063799006|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: lAS2PcczsR+NFEQjEFXYWL/xfYLOuQQ0CLv5uqw+IuM5D6aWOJOpinBa39NAV5eaa3JWLukn5KNptWo8pIgqN2SmF6JfvZ5nbZ+h3qae356Nxmm71edX+OkBqZt5DcD+XQKHyhBpH8jHIOKOAkhXvTJpVHiBVJ3MeBAuIvzfWzDa7ZFLnDUpTBp79AqPoLmn1ICEEtByiQI/yFrpCwn6U9ovT3rki5PXL4Ds2aZKvEM8upL2twT3Hipy/ijfKcXpbyfAWXkwKKmYYqG8cXYjR4nEsObkj0CgHqenGMqIX1OwE8pYsDbWWdMOGdM58cBuTnQLGfvhXo7b2mOzc+zdHI4jseGeBNYtDBlBp6VYawKoqvW5oJqcZ9us7nxP+qbjnmifixejYVzuc1Q4/mbxjmEPiINAIYmRe3xbND/HLIlL92iy742cEd/mOxEt+j+m8xiprAhd7U2cjJwqPBllL90h1YAAiEnc8CZ3CGHjAY3x/6iIa2cakKb4BPqNgbPglT8sokgAt/qR47eksPpRG4Rv3O9eUvgvJL9/O9JGOjCC2nvxZ3Q+vFVkP2XDeP2Dv/tm+XCmQgb2bSZLWlImLTq2lPnOoJV1zwzfTYa3/w7J/097WVOUzhgYIOBypATS01gWFcqZX8CNWCLlxtPKlTeoVek+40qQfqj/ySnhyheU8T+275NHPxhN6uvknAwXkFcHfM4ZsSxEg/nXULtxP2ZOPt3maNCjDLjIVDkdSbs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MklINWVaSXdvZEZNZEhuZU9WTHVCY0M2bkV1d1MyUnkzR25xenNZQWxZcjNJ?=
 =?utf-8?B?UmFSVFZsdlE2UXRya1ltV1NUc2pnQ0RGY0xrWVI2WkFKc3R2MjhqMURUU3ln?=
 =?utf-8?B?RDdKcEFablpjcFEvbFBKNlkxM21GdFFZdllFdGVmSmxYS3J2VXhjanBYL3Rx?=
 =?utf-8?B?S0hLUUVVRUM1OUZLN3REVlQ3eVVvcDI4ZUJSOHJJTytrRWFyTm0rS3cya2ww?=
 =?utf-8?B?cFIrTDRlTmZUREhWT3hhcnJHQkZsRVN0QmY3VDJOOVV3T0EyTmFJRDdGYnk4?=
 =?utf-8?B?ckt2cS9pTi9paStWRXNGOHpyVzNIeVQ3UElVYWZ0RlVVK2orWFd5QkRrOTkr?=
 =?utf-8?B?RjRRVFVKQ0pnMm8zTUNYQTZBS0FUNkluYXZsVXQrd09FK0dOM3BvbExJUlA0?=
 =?utf-8?B?dDVsQ0hvNGRUbzJvcHdrVWJGZG5kdFUwb3AzSW0zR1FRZzFUOVFBMTFRTW1M?=
 =?utf-8?B?NWsyVkRNUnFXUzczU0VrU3luV3grL0F3WFhxQVo0NWJRMFM0b2VQWmNIT1dN?=
 =?utf-8?B?cjJuai9wSS9OdWo0cCtMM3lEY2FKL0tLb0lYUEhHempRYWJpUTZaNzVaMi90?=
 =?utf-8?B?ZXQzUmN3R1FFc1NTakxCc3VzZEV6M3ppUFFONmIvb2pxMURIUkNCUUMwZUha?=
 =?utf-8?B?SDhRS2ZsTGhVL3BzeFYwOE0vWnVMZ3Vxc2JDK2t6YWRQNEQ1TEdrUXVMamhM?=
 =?utf-8?B?YkdJSkVUWWhEVHZ1a29qUTR4bGlxVUJhckxIMVF2b0xmM1RrWmtHaWRUK0RT?=
 =?utf-8?B?YjVFaE5VTEljKzdiUHd5RHROK3MrRHFkck0rUWxvK3U0cWF0eEJ5RWhnVlps?=
 =?utf-8?B?OEVISTN2K2xOWWFOMmxtOWx1ckVuck5pR1p3ZTRWdGFaZkE2K1lTMERiNWVo?=
 =?utf-8?B?dVpmVEsxZDIrd1pBOEVZNmNnV29rTmh6cWZnbGdmdkZURDhYR0hBSHRsM1pr?=
 =?utf-8?B?RlU0NVFjRXpEKzEwelZYK1JJQURCQTNCL3BOOFlCb1lYYkhYT0NtendHZ1Jy?=
 =?utf-8?B?cmF1VnZOaDRWQ1pBeWJzMmRtNDYwWkRCdklHTmxGZyt2eFN3UER5Umd5UDZi?=
 =?utf-8?B?UmU3b3JESVpsZmtna0lGYndHN1BNVzBMdFFSZkoyVDFkQktLV3hmd0xvVC9w?=
 =?utf-8?B?K2tuQU1qd2hTTlNUM1k4V08rbjdOMjB5Y1p1ZUxiU0E2d0d1QWdZVUdrcXJx?=
 =?utf-8?B?RGJ1cTI4MkhJUysrbUVFNkVkUkV6VExKN2JBYnQ2M0x5aDRUM1ZUdnVFZlNW?=
 =?utf-8?B?Ri9WYUl3d1ZhN0xWczc2bHAzZWJBUjBwa29GSGJOQUdyTFRBcGdnMmJYa0w5?=
 =?utf-8?B?RWdmamRaR3lOWWVPMFpQdzBuWm0xcm5kbDkxS095UnpGQzd1Q0k3MWZ5NEY3?=
 =?utf-8?B?cHRnYndPZXIycGJFRnpWaDdEOURFQklxR1drVHhDQUtEcTMzbEMyaVNpOXZm?=
 =?utf-8?B?SStFckg1ZnlRTE9CQUNQdU1LenBCYWdmTm9GNzRVdzcva2xpdVlDMStLYUhr?=
 =?utf-8?B?dVFUaU9WZ1orbEk2SVMvVVcvQ2xYTUlsZk1ic2dzRURKN2pyZysrbkhuZnY3?=
 =?utf-8?B?NGYvcDZzaXZ2T284MjJEcGlOZlJvMVdrNjdKM0YxNUNRcTAyRVRnYTlpSVFG?=
 =?utf-8?B?eDBZdFpnNjFnOW5ad082SUQreWY2Z1lud0tGNlJUQzJRVWh0bjVzcEYzVUFL?=
 =?utf-8?B?RURjUmhKUDNiMTlLZGZWcktGMXMrU1BrWHh2R1RkY0dnVDNna21QZ1c3TzBF?=
 =?utf-8?B?dHRWYU9kVktzejJQTldBcWFoMzRxcXd2RktTZUI4SW5rOHU1c1NsWWxhSkF0?=
 =?utf-8?B?TkxLWDVjaVJ5bnlNS0lZRUtRWnhsM2lZQ1kycGJ0QXVESEZzVnpBaFlNanV2?=
 =?utf-8?B?WFRTanhSbTB4NGpMeXFUVWU1ODVCU2lZM25Iek51S3pPb3AvN1V6QUllM2tV?=
 =?utf-8?B?K2FUa09SQm43K1dPMEQyNU9ZMmRTR0o4Z2JmNVJ5dkhTZzNlOGNvclBrTEs5?=
 =?utf-8?B?elAxM3RXd2ROcHc1M1VNVk5raE5XK2l5NDZlVE9RUHBteUJ3djRDdzk4MXhZ?=
 =?utf-8?B?K0VodktqejM3V2c1WHdXeXMrZHFsdjJDa1Y2UGxORzF1bm8wbWVYaXJIMGZr?=
 =?utf-8?B?c0E5NzZqVU5FTGx1SmZHZVVPYXh5TEJINmRodkVjcnRXOG13ajZuMFUvdVlr?=
 =?utf-8?B?cVRHcGVvdXU4amlhcmdtSFRDWlZFUEVwbGM5cGg4U3orRWtpZHFKSHRROHpC?=
 =?utf-8?B?c0tpNG41UVFxY01KbXFJbjlXMnoyKzg0QTFyd3pFRnhRVXRnaFVsZ0dxL0l3?=
 =?utf-8?B?cDRvTCttRi9mSkM5QjZEOW1yem83NVhsd3FxaEovUkNqZGVnU2RiS0JrVmpL?=
 =?utf-8?Q?8EC6iMpQgO4QD9jI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB1DBC588F812A448CAEB7E9A3EA3C73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CYpx3eb1+Y7sYOjFw4JxAKWNtY6eeam7WBHKw7zjPgByFprBgyu279LzXxPTjT3PVlAb7YXehhYlqb4uhZ5L5uJ0GsHY/QmUKr8hwjkj4PnhOSLlFSC96gxsYBccvbHRkIaTsN/OQjOQUgB5SJytpkgUt4xEvQY/7S58D5k+ckG2ZqsD6+M/FiTQOIVNT+3asx9dVOTG9saMgktE5IvRqGnen85d0y6wXM2n9fpVa3VaoPQM3Fw4vndnSe+QBEKRg/uG8fah4dJwAWV2DdCpNRigQgIFEDPhTA1bxUpdsAPYKEwLy0t6zFk9nk+jc4T1jgTDSm26M837bsy1zBn90Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691294ad-0b59-485e-b4d7-08dede1f424f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 01:04:57.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCn33JKni4kGe/ejR+FFpG9joP0E98W6Rb9vGVa2LJJ2mgGBFXbCYNDcGRc2I/EnCWo7CA9jnpKAZO0Crh2aLWe6246k24YTJP1alCvzFGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7146
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDExOjE4ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiA+
ID4gcGFnZSBiZWZvcmUgZ2lmdGluZyBpdCB0byB0aGUgVERYIG1vZHVsZSwgYW5kIHRlYXIgaXQg
ZG93biBhZnRlciB0aGUNCj4gPiA+ID4gcGFnZSBpcyByZWNsYWltZWQuDQo+ID4gPiBIb3cgYWJv
dXQNCj4gPiA+ICJTbyB0aGUga2VybmVsIG11c3QgY2hlY2sgd2hldGhlciBpdCBpcyBuZWNlc3Nh
cnkgdG8gaW5zdGFsbC9yZW1vdmUgUEFNVA0KPiA+ID4gYmFja2luZyBmb3IgZWFjaCA0S0IgcGFn
ZSwgYW5kIGRvIHNvIHdoZW4gbmVjZXNzYXJ5IGJlZm9yZSBnaWZ0aW5nIHRoZQ0KPiA+ID4gcGFn
ZSB0byB0aGUgVERYIG1vZHVsZSBvciBhZnRlciBpdCBpcyByZWNsYWltZWQuIiA/DQo+ID4gDQo+
ID4gVGhlIGNoZWNraW5nIHBhcnQgaXMgdHJ1ZSwgYnV0IGlzIGl0IG5lZWRlZCB0byB1bmRlcnN0
YW5kIHRoaXMgcGF0Y2g/IEkNCj4gPiB0aGluayBpdCBqdXN0IG5lZWRzIGEgYmFja2dyb3VuZCBv
ZiB3aGF0IGlzIGhhcHBlbmluZy4gSG93IGFib3V0Og0KPiA+IA0KPiA+IFNvIHRoZSBrZXJuZWwg
bXVzdCBpbnN0YWxsIFBBTVQgYmFja2luZyBmb3IgYW55IDRLQiBwYWdlIGJlaW5nIGdpZnRpbmcg
dG8NCj4gPiB0aGUgVERYIG1vZHVsZSwgYW5kIHRlYXIgZG93biB0aGUgYmFja2luZyB3aGVuIHRo
ZSBhc3NvY2lhdGVkIGdpZnRlZCBwYWdlcw0KPiA+IGFyZSByZWNsYWltZWQuDQo+IEhtbS4gSSdt
IG5vdCBzdXJlIGlmIGl0IHdvdWxkIGJlIGNvbmZ1c2luZyBmb3IgcGVvcGxlIHdpdGhvdXQgc3Vm
ZmljaWVudA0KPiBiYWNrZ3JvdW5kLCBiZWNhdXNlIHRoZSBrZXJuZWwgb25seSBuZWVkcyB0byBp
bnN0YWxsIFBBTVQgYmFja2luZyBiZWZvcmUgdGhlDQo+IGdpZnRpbmcgdGhlIGZpcnN0IDRLQiBw
YWdlLg0KPiANCj4gSG93IGFib3V0Og0KPiBTbyB0aGUga2VybmVsIG11c3QgZW5zdXJlIFBBTVQg
YmFja2luZyBpbnN0YWxsZWQgZm9yIGFueSA0S0IgcGFnZSBiZWluZw0KPiBnaWZ0aW5nIHRvIHRo
ZSBURFggbW9kdWxlLCBhbmQgdGVhciBkb3duIHRoZSBiYWNraW5nIHdoZW4gYWxsIGFzc29jaWF0
ZWQNCj4gZ2lmdGVkIHBhZ2VzIGFyZSByZWNsYWltZWQuDQpJIHNlZSBob3cgaXQncyBiZXR0ZXIu
IEkgYWRkZWQgYSBmZXcgbWlzc2VkIHdvcmQgdHdlYWtzIGFuZCBlbmRlZCB1cCB3aXRoOg0KDQpT
byB0aGUga2VybmVsIG11c3QgZW5zdXJlIFBBTVQgYmFja2luZyBpcyBpbnN0YWxsZWQgZm9yIGFu
eSA0S0IgcGFnZSBiZWluZw0KZ2lmdGluZyB0byB0aGUgVERYIG1vZHVsZSwgYW5kIG11c3QgdGVh
ciBkb3duIHRoZSBiYWNraW5nIHdoZW4gYWxsIGFzc29jaWF0ZWQNCmdpZnRlZCBwYWdlcyBhcmUg
cmVjbGFpbWVkLg0KDQpUaGFua3MhDQo=
