Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE52D1931;
	Thu, 13 Aug 2026 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665040; cv=fail; b=pvbmWOv7eaQZ0xFXvHgCOgkyeLC8BaXqtbW/20mD7gpX+fia/gOcI6iiZK4So1tsiNj4D5Mv9uXsM3WhqZQvQEEVAhzgqu3ersJrMq6AcnqAyZMaZf1OHJxBPmyL4/a8QrG6kCcHAIzS0wpthBhO6RhJupix/xkkjJVx4QWCvhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665040; c=relaxed/simple;
	bh=NqRemvRfX02//VZ/qpo3AyL9FCmeUg1VNbwcPLMpGjw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+Ykg95wxNIwPH4HLkjoKWrV5OpEV2Vv2hb0WDqWE7PI9KhXz3bvMPQLqKAkBJLBWJLVFCg2DouymycwK3vxes/wxSmjXQi/+vn8IUJy/fk7hLXkKUOkG0HJ6jBUJ6/hvQoThJE5RQQQe/m2MS6RjYwRx2eBwk9YDrPc+9axSM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwUCC642; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwUCC642"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786665038; x=1818201038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NqRemvRfX02//VZ/qpo3AyL9FCmeUg1VNbwcPLMpGjw=;
  b=OwUCC642Yf4YgPpQLrGFyh4zdi9J4SmLUwp2cIvmx7vhoFruexbDpSVL
   nYiKseJ5N/tgE8V4+1mxx3FPwIrLq+NONBxLYGNlfG5KkoA4wBjPQ4E7q
   iQmXrNNC2XrEU6kwGda08orPHg2QkM1JLxxWpM7uhoLTXOsf1W+tYoD3J
   l7XrHMe77mS82Y/2jt88UpefdChZTsrT//YhNcRpeFL6E/MdmR3u7wgow
   t76fZP1mAy6/7M3BN24Pw3Wtw7J4VevzIPuPJQ4W0t6ssjP9HanPbjy4O
   8+HKniUzffmVzsFbF66OYRcK3iB28/VXw9NKAtTORE5uGpM876sJo2u/D
   g==;
X-CSE-ConnectionGUID: I7XMFNqBS/uo1yZJ+nB+vg==
X-CSE-MsgGUID: jNuk/K35SD2gkKTi2o0ohw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="104781072"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="104781072"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 16:50:38 -0700
X-CSE-ConnectionGUID: sn46A03TSVCo0dJqZvyPdg==
X-CSE-MsgGUID: S+4sxRngRXO2VQ4cbmHcwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="302315877"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 16:50:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 16:50:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 16:50:37 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 16:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw3dRbbNY08iVTM7B4ddW/T2SWbhUXoB9RTT1M6Kf4Er8xavOgcGRnZnSPm1gZyT/XWzTojjtHgsVuIan4E7vrOMHoUGV2D7lTU3KHpdy2xMg+w+cYw2dtVfMqoxjWfopUdC3p1GIT8WdTtl/vPxyMDFCob/VGxreT8QgiviTBimyWUa8uI+ox+ACrVnedELrovOuhWWVgfqhdx8xfpDbbM01MhucRh/VxCr8aTE5SXPUgqWU5vP51x8YxxrJ9/fdt+RzlZhkphiYNyuF7HummtSHBInyuvpK+APh5mbsjfwTErgtdgz9u2CDDqcVRN2T9IYfV8wjQ/1fngEF1EAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqRemvRfX02//VZ/qpo3AyL9FCmeUg1VNbwcPLMpGjw=;
 b=piPtAoQNB/qfB4ZWbag9wD34HrxHRkRxCoI0LYZ3vx7z1nzu2C1hV2TH3zPmSzQrIeoudPmiH2GXEJb9vWZkMUEgE/7Chc0C5rX8bqjed40relT4gr/bhv6amwO43pDLWygdb9x+AvImjLpfqVrmM7V0yfjYQZa7V65u+k53B8kNogahlYE34oUVWr6fIUlBSLCGdltCiVghYQXFhPf48yRNfOp9vI583u2GPf3qYfe7PLSwKxnE3kQS37EAUR5mbFW/Mti8IwKjZjtzUw9ASCnmRBJLuAU8aSGS+HCLbBkV76OqjYPWT6whSyld+Yh1TlTSGiSmMHLD71JBcNTZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 23:50:32 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 23:50:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "seanjc@google.com"
	<seanjc@google.com>, "pratikrajesh.sampat@amd.com"
	<pratikrajesh.sampat@amd.com>, "oupton@kernel.org" <oupton@kernel.org>,
	"wyihan@google.com" <wyihan@google.com>, "sagis@google.com"
	<sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>, "Wang, Roger"
	<runanwang@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 05/22] KVM: selftests: Expose segment definitions to
 assembly files
Thread-Topic: [PATCH v14 05/22] KVM: selftests: Expose segment definitions to
 assembly files
Thread-Index: AQHdGi/eTdppMukm/0C1Z9ME/lyEOracyKyA
Date: Thu, 13 Aug 2026 23:50:32 +0000
Message-ID: <62f593407a6cfac18c409df9495c5aab897174a7.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
	 <20260722-tdx-selftests-v14-5-15ad654a50db@google.com>
In-Reply-To: <20260722-tdx-selftests-v14-5-15ad654a50db@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7529:EE_
x-ms-office365-filtering-correlation-id: 9ba3f3df-77cc-4a65-8b89-08def995a99c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|22082099003|18002099003|38070700021|11063799006|4143699003|56012099006|10067099003;
x-microsoft-antispam-message-info: hJtkAVOZW+247360a2VpkmkAI6oKA+GyW5dVkYfvMrH8uUai66wQdZcBTwcFqpWaBi6cYmurlp/dzdtiKjrmt0xNjK9XmmeAJZdQp6DgM86B2E9ereo67vPYnegId7RzNnfhCIReO3710l4t9CEHI5AVzs6fIEWAEnjgWYsOAgRoZ1xENTDLWs8QeYffnHtLVqIGr69os+GGToXt1HfMMevCZBsQmBOEQGubPcNeEaEAX5Ysj9q1TEy3W4KHJLicm2g2hh4LX/abuQJCqtTPfLRlWGcX1RuPRiFBsSGskXVISPRf7UvaDD0MIlvXTECqx3wDrFg/MVPHQTz/j89mMdAIIOtWt0VZ5IzOuWKMe15FZ43JilQ0dkcOaJi6Ui5/G+TIvmWzDGZivWGe2QJircq/Blno9C+kVrinrMqCv+LD5OVZ0bPRjD9/EijdPUzrZw5GclxRZCcXCB05WJXz31XE5ABXyTWJF2v7ErtRN5KeBNeEj7i8hx5+Qr7vXBcHkI6zjTmAn8F5VaHWSc9b4BRk8wPFPBiqJYYkNgxCIChGLrGLzq3AzXEwKj4K/V0xqahfjq04EXM3xgsl6jr4D1RaGB1WU8Rip1YutxZVK17fF2I5ohg4DG1TdKpKQ7ux2rta9cpRtANsHVp9YKMDV8EQyBHC403kgnrhoJwv7C6f0Xg9dZCzioYub5adbjdgCzfv22oYEOobgTI8kAqYtuS9NiOcL6vLhd4GyaLr9QM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzFDd3FwRkZUOUg0YXVJT3NVTnZYdkdOblJsV2hVdlBzdGozWEx5MkFvaFZU?=
 =?utf-8?B?TEtkVFlNTFRpVmJZSmgrd2NjQVJnOWk3ZXBOVFlJTyszb1VTMUx2UTdMaUZK?=
 =?utf-8?B?TmlNN25RRnVKVXdvV2pueWszYjVFWkNUOWJISjZFWkVvSGNNeDY3djNYT0l5?=
 =?utf-8?B?NysvQmdoVzhTaGJxb2wxTGNTSFNGcjBIK1JvdzhvWk10N2dkU0hoU0FmM3VV?=
 =?utf-8?B?S2owdGVnaVpsRTVMSjdIVDdaam05clBhUjF4akE2QmdnelJTUEVZZFo1RXBK?=
 =?utf-8?B?eEIzOEhuazJoT3NselNwRzczTlJIL204UUpKMVhFNXpTZkpORGdqUVdUeWU5?=
 =?utf-8?B?czhWTk9rYm5zM2l6bWk3aE1oQm0wZ1h3QWV2MFF5am1JTkphbVhGbCtmNXZK?=
 =?utf-8?B?TXZmODZBSExmbVphNzU3MkYwayt5Q2laWlpLMDRNZDFsbEltbVFVUllIUzE0?=
 =?utf-8?B?clB1Z3lFdk5rMlBRdEQ5TUFHc0dMS3c0dlJRN04ySEhhdGxHNHp5QVZBUHQx?=
 =?utf-8?B?aG50SktJN3FLL2hKS2Y1R1ltTkxSbFdOVjgzZTVjRzBLNTlyQjRzQzg5bW5Q?=
 =?utf-8?B?QUR5RWNiZHk0eDFxYXpRdVh3NCtaSXJCYjQveitWeER3YzFkeFpibFU0aHd5?=
 =?utf-8?B?RlFpZW1Id2ZUblVNMnJxeEdHRWdGUXlIR3hsN2xMUUlBYnhqVEpWTUpzRGFp?=
 =?utf-8?B?T3VXcnVpdVN6NUNZWTFaYXNXSGpHWWVGOGtiS21USnhINHJkdjdodmxLRW9M?=
 =?utf-8?B?UmhqTFd1NDFBNG51SE1xcmU1bjkyQ05SeHJzdXlRdTRxcFZrM08vaUFwSWdm?=
 =?utf-8?B?Sm9QODEzc2VoYkQ4VzlYeU9vQzNFZUNreFg0LzlpbzBBQ2RLcFN2bzNPSXdy?=
 =?utf-8?B?NjJ3RVY0eTdZQkJwa2hmdlZ1WjREN1NDaFY4bUI3NXdXZll0dVJiQVdXbFFu?=
 =?utf-8?B?bEd2eHV1TXRZd2tzSUdZRURieVYxLzJydjU2eWNmdi9qVVNaTkVzNjJZS3Ry?=
 =?utf-8?B?NkZicnJac1p6cmdUeEExd2VUY2VabW1FckJXUXlwMVBocko2YU00dVVuclJn?=
 =?utf-8?B?bzJKWS9ESGl1emkyOVVXa2U0Qnc1QzJJRjBtcjZJaXY0MkZ2RGtBcnRQWHlX?=
 =?utf-8?B?MDExOEtlbUFFcEtRVUpKcWl1NjU4bnJNNjRWRUhBQm91b2lBSjRQVldIMThr?=
 =?utf-8?B?QnlLVUJ6cmtvbHJXbnBLK0l4NXJNWlNHcDNwZ3MvcEFJZlBTZ3E4Y2MyS3cy?=
 =?utf-8?B?aW5pWGdXV1ozTzBJaGRFaFRPQzVmQWE1dEllSzlEU25iLzlLUUtBQWN5Y0FY?=
 =?utf-8?B?d0lZSTF1ZmlVY3kwT3RCNDJJZTZHUzh2cnh1STJFWEN6OEpWREtTOWNjcUt5?=
 =?utf-8?B?UVROTFBvNkIxT2t1QWhiTE84bFUxN3poRnhXbDBZSEV2UjU2aHpyM3dRbTRL?=
 =?utf-8?B?YnNsdzEzWkUxTHVubXZ1ZUx3SWYwOEptNUprMG13UDhTY1NoQ1ZrcDJOaFJT?=
 =?utf-8?B?Y29WK2NPVy9yN0hYRk5BR1JmRFk1RVZJNld6QzJYOXpkdnpVRm1lc3o3SUN5?=
 =?utf-8?B?RHg0Zk9IY3l0Uy81NUNqcmluUHRHQmdQaUU4KzcxcERJaWlybEVKV1pxUk5U?=
 =?utf-8?B?RW5lajlIVlpGeWdqWUFBb1hxZm9QS2lxQ3pHWmRLYXpERkgxb2kvRTh5Q1pl?=
 =?utf-8?B?SEFxRDF3Q2xMbnBKamhqM3lZdXgyOXkzN3lYdG5UVUpMMnVjNTJONWIyOEhE?=
 =?utf-8?B?aHlVSGpxWnQ3OGdLaEdKU2ZEM2V1RFUyWDM3Uzl6UW1SbGpDQWY0YnZtTWdl?=
 =?utf-8?B?bE5WSnlqYWR4S3FaWlR5Z2dqZzZ6dTVGQ0FBZ3BBYTh0azRJSUJkMzVQTjBk?=
 =?utf-8?B?YklPZFJ6K29XdFdyTldRK3JiMVdlcE1QdGlwYzA2TndIUEs2RVdYRjlBMGhD?=
 =?utf-8?B?UDhFSG5YTzdYT2hrcGlsTTRaY01vOE1xQVdCNUc0TWl6N1ZLeURWV3VybnRj?=
 =?utf-8?B?anh6bEIzMERteXBPNTZDZ2kvWU5FVWtSL0VxQ2hBUHRUMW5ZcUtDR0hvNVF3?=
 =?utf-8?B?UVZwMGlMOCtaZHRYTExDNy9nVW1HUWcvT3Z0a0VLQ0VHL2pwMURSZWFYOENN?=
 =?utf-8?B?UnplOVc4NzcyTW1kWmxLSERjeEcwNUdhSGl0VUY5WWxaVURySkhyTk94SDZu?=
 =?utf-8?B?SXFCTXVwcEMxamwrMTUwZitiUVNmczkvalZ0bWcyNVpkNEhLZzFYUlc1clJ5?=
 =?utf-8?B?QXdrRUVIZ3Rvcmo0Y0I0UVI4aWhwZ1Vqbk9tOEZ6VmxsaG9DQ0poWVFyTUVy?=
 =?utf-8?B?YjJ1ckVNUVFSYlMySnhRYTVXN3YxdkVETTdoTENFTzVyZUtJOVVqY1RMbVFh?=
 =?utf-8?Q?ZmznkX2uMj/fsPqg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61D3AFAE27F93A4FB23ED8EA8B16DCB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aVWh/tGTeSbmke6hxUHq1UbA6QuX/cXdbjpW7Gj1+Jfg80+R+kpBubZMpQAQOkI613YSMrhfW6z4fZS60Bew02pZQeCiR65SZ9qbJltbIBFZQYtiRPqXmegEpu4nQ10gghwlcUtVTS4ZlhtNZZqB8TSugSIvB5dVJb2UcFYCXchOZjiTgpqgrq/utWMRBO2sFRxhDyL+Ijsf6O3fByveJN7jvcewp+rVI5BxUQp7obbGdPp4Sl0RFlwUQehOHhwLX/N8mWkiNl1wvSQD+3uijuH3KZ33dYeAAugbJvcJ1lrKRqgDkymxLW0ndDuM2PlA7aemxVu7I36N1KAJZdu+VA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba3f3df-77cc-4a65-8b89-08def995a99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 23:50:32.3890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0kv9HixKKhzhSPimnBl4T0NCdYsnRiicDZI+ZiMT3GfLi++L80l13Pq03rSVUMhMyIJQ7sYaKUOAkfNla94SUcc742PgXWdKfe0oCKcyyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDIzOjEzICswMDAwLCBMaXNhIFdhbmcgd3JvdGU6DQo+IEZy
b206IFNhZ2kgU2hhaGFyIDxzYWdpc0Bnb29nbGUuY29tPg0KPiANCj4gTW92ZSBrZXJuZWwgc2Vn
bWVudCBkZWZpbml0aW9ucyB0byBhIHNlcGFyYXRlIGZpbGUgd2hpY2ggY2FuIGJlIGluY2x1ZGVk
DQo+IGZyb20gYXNzZW1ibHkgZmlsZXMuDQoNCkxvZyBuaXQsIGl0J3Mgbm90IGp1c3QgYSBtb3Zl
LCBpdCdzIGV4dHJhY3RpbmcgdGhlbSB0byBhIG5ldyBmaWxlLg0KDQo+IA0KPiBSZXZpZXdlZC1i
eTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQmluYmlu
IFd1IDxiaW5iaW4ud3VAbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIFNo
YWhhciA8c2FnaXNAZ29vZ2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTGlzYSBXYW5nIDx3eWlo
YW5AZ29vZ2xlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFhpYW95YW8gTGkgPHhpYW95YW8ubGlAaW50
ZWwuY29tPg0KDQo=
