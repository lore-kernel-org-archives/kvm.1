Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BB1DFDE;
	Wed,  1 Jul 2026 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864404; cv=fail; b=YZMxHXWR2R6Rb65+LRdp5w0FElgUbMIxeeacsJDG8YQ9WaTxsuqcmOBH8EMlsn25wwds42YbvxyG8eeSsZsCRTO3KXXibUmW7faP2ZAYSFdL3We4aNJkxLoFfqo2CWnqdlS6hmEMhRQR9qHdEC/Bxut4avem40pKl51g1X7D8c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864404; c=relaxed/simple;
	bh=CNGKOnyODNrJsc/vJlI07pXoAbMlR9NnmmYM0CjPqw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4GRgexutiDhX3xM7C76X88oMPIV328huJuPUEiIKT1ycfAMpD56Cs8twygawY/w4ATWwXj3vAxSm6Ucr9hYeep4ynO/tNhdVIaRNb3SRwyCvN2ius+qBJ/t+vtRy0LlFZddwCIjr7hV6Wy0VBlX+LrkN1wyEJJBh6U++t9Pmek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHC8kzew; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHC8kzew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782864403; x=1814400403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CNGKOnyODNrJsc/vJlI07pXoAbMlR9NnmmYM0CjPqw0=;
  b=fHC8kzew9P3XmOqGw2KN9kLrw2YCicU2fmbypvTboZAt79IcOvLp6I7K
   BtpSEzydbvYSPvqNT5Odx0byZMXTNjaubKg3DMwx+aQBekTqSdv6t9TEt
   GGJJr1PNVL8MYRFMMFXzc8C7rbcxMudF7uX+4HHqKSv7z9PiSzuYidmpT
   5mQPLPBnCt3WQnx8z2ZZKzklLBhhm0Hc38ql34cbGfOjvCX6xEUbUfUza
   ZsdXwPDUVEVgfd7Xl2zJcYf0eG1ucaAJWaSv2xaG8zLgCF3m7xNtGlHEW
   PGVt3pjSKVsdbqqxrK0vbjxdchUwQgfmwfPYdBvQXCOaSr7qNeYmaCh47
   g==;
X-CSE-ConnectionGUID: X/xcu6C8Sq2ZUDnSwk2ouw==
X-CSE-MsgGUID: gClO4wGRQeK04k+lsR+90w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="101016357"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="101016357"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:06:39 -0700
X-CSE-ConnectionGUID: D2WU+lQ8S9WCQnuf8DnhRw==
X-CSE-MsgGUID: +F8+L91qRAKwyZrLxBN1xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="282472989"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:06:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:06:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 17:06:37 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:06:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1Zj9XfpzGuGXwOVGQ3vMmEiWu5cGoPZlzCgs6cPD/6Y0sz+HZlIF11JQliK2AbUVts7LECHSG8GAUIYesXgQ/L/hevEONFrQj/F/Bpr4vHtMxNH3qN/wC/EQrJqIPOOpc6E0VsG2fEWqu0NLCjGCuWc+F0ol4zusP5LPbs//V+a7hMvkESgZDBDEmuWIKK5Ba+1m4pxu/NUekmGgN37ZMkATuNmlCO41BiYwlBVA4TayzOkukFVSCQfgWRydK5i3ISTCnz58UwJEoX2hp4MLLd06K+Xma6mMlF3Q3Hqea0d+ltEnCaDYpKfheIGxCxgy9sbD6xy1y6EQCyMIBjejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNGKOnyODNrJsc/vJlI07pXoAbMlR9NnmmYM0CjPqw0=;
 b=NgXVrxGcgBUC/UHyuPXLYixnGTrXmJPQbyeOfhdTAVlRpfUgNB72F7Q/ebV+1SVz4gRPRK6JdQwUswgTvaYfAZfWPcBQ3bG35Q08oCUGwUiZTRgzNeSuAgy8Tzh7OT3rXSKsVU/OOm7i0w0EcCfRZtM4DXDpY/Wl0P9tSK1oT+nhj0BUJXxgYWi7jh2Tbu/CHOSt4qxsTU7loTGQ2R+dyzz1h3H1pyyHpY/2gzQLcJJzluQJmk+ZylEhpNAkOpddlVYjPbtaWuoB6FfDz0qsNaPbVZV6ysA1GOzz1Jgshy3T67LRhAPoboP4byGTFa+BUaGVAHYdYcMqVNH8nq0ciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 00:06:33 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 00:06:33 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "mingo@redhat.com" <mingo@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "Huang, Kai" <kai.huang@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "tsyrulnikov.borys@gmail.com"
	<tsyrulnikov.borys@gmail.com>, "djbw@kernel.org" <djbw@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v4 2/3] x86/insn-eval: Add insn_assign_reg() helper
Thread-Topic: [PATCH v4 2/3] x86/insn-eval: Add insn_assign_reg() helper
Thread-Index: AQHc9DEVgO5Lz++WtEabQ70leVOr+rZX8o8A
Date: Wed, 1 Jul 2026 00:06:33 +0000
Message-ID: <a038a3dabd917b0da28059fc7b0116996b099868.camel@intel.com>
References: <cover.1780584300.git.kas@kernel.org>
	 <daac026e677c10b68740b16ed8ad2556bd9583f8.1780584300.git.kas@kernel.org>
In-Reply-To: <daac026e677c10b68740b16ed8ad2556bd9583f8.1780584300.git.kas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|SA1PR11MB7109:EE_
x-ms-office365-filtering-correlation-id: 802c84e5-1a9e-4252-8833-08ded7049c3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|38070700021|3023799007|56012099006|4143699003|22082099003|11063799006|18002099003;
x-microsoft-antispam-message-info: gwPR+m+SKxdQi8CIL6BxlZ6zZ2Cr1Ms3kV/7ryP5oAh1rRJWjnGKlQwzOLUyjzRTfL1j+O1qIa2b4UUm96WQ4SH9LOuEUIQfAzCPwwxfBKL7be3cYzNRff6UQEj/mlvdiaE3YG8PFtEFubrSSLKl1y+9Wu4F3tta8wRORjnahOkZVVa7rXe15ME9x2HjOnui3yYWPI05ME0uOxzUA6fTXZNQ3h583Qf3S1FsCbMzdiv28m2bs1/u3Ee+PATqZ52GXyy5XZmsJsvEeEoJx7wWDqEivpjYQMnn+9A5ToZw0QwA9TGp9RoKqc1O+QTFqpwLSwUx4cdPA7SXx7+Db0+sd/FHsTYll2MDHXR1FzwZEakEqg1+Nj7jcV9Oev+q6wk+m5r6KnUwzmq7ap/fgqGnM4VIM0dr1ZPMaIW9yJaG2zqLDSw/TK/MlQnKFXk+X4JUWQk7J2BX9/KrS7n13uWlbPukrhQLFOz27OdMEWJK+iHHG49w26Cd/LkAXBcuNlFrwczQzC+fw4T+YsZnYyfPXaw06djxaBDiAgUONo8Ux1IMBaUtG7zCKhh5BtrljI0TXEBvQWjgYsw/Izjx2CklU/Nv7F6Md2LlkwGO87KKW1puF5nEtrpR5g+mPBFBNQ62tIBqcnmIcNKbIt9u3BMdFx69M+Lyl3Z9HpRdabcvN1u8xop3sRzWiwi78Dev8AWgkRTUkWDI0Q1b6rrM+CtoIodsz0t4QH6e41q15wGSdO0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(38070700021)(3023799007)(56012099006)(4143699003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGNmVmg0MFQrc2NrWnRLM3RBRm9IbDk3cEtDRHNTaG04Q094dDQ3VU4zNDZ0?=
 =?utf-8?B?TndBNXAxVk53QzNRNStRaEJNbVkxdG5hcHRDVGkxeDlOajgzUldnNEZkeUw5?=
 =?utf-8?B?UkpScW8vcHhFSnVaSm9TSTlSYU95SjlQRUNvVzZBWmVDQW5KTkFYRUNMblZD?=
 =?utf-8?B?cGg3VGRyL1hsSTkyK0VEYTJsT00xRjJMcm8wdWNrWHpyV1lKbHE3ZGZORG5E?=
 =?utf-8?B?WFV2MzNrdzJVNi9CYTlzTVNtY0IvQ3k2T0NLL3JrMndLVzM2TWxJUjVVN2Ny?=
 =?utf-8?B?RDNlRmlhZFgxZVlrZzNYSXNZNkhuZjFXb014b1F0bWJqMzdmVnQ3ZTRuS0ds?=
 =?utf-8?B?SG5PWHlyYnppb3c0K252dzBnRnQxMkg2a0ZGeVZtYkdzZTJJOEl4TisxSnZQ?=
 =?utf-8?B?NmxZUG1Bb3MzbGppY3NaUytYa0loTVpDQ3RuQlBvVXZsd3BzalMxWjByR2sz?=
 =?utf-8?B?L1VneVF0bUZZcmJDWDdsNnNCR0dodW9lQkptc3NTN3hpUmV6UXRxbjZmU1Zx?=
 =?utf-8?B?YmwxUy9QNE5vRVNBWituYVhEUTNkYjNodStvSU90UmUvS2trRFpUR0k3NFcw?=
 =?utf-8?B?bVZQRVlrUE9VaUpRd1pvYVZJa1Y5U1B4cEZ0QzY1b3RHMVZSZ1hEbitlUERT?=
 =?utf-8?B?czhFa2h3T21Ec0R3ODRYZm53cFJOUnQvMHk4SjVpb083UnphbjdVS3lQZDFM?=
 =?utf-8?B?cW9jSEhyVjBBT2FQQXo0K2JjQVpRQld5SGJjQUFMelpYTFNHalFIQWg2WFNT?=
 =?utf-8?B?TEhQdXRZTXRuL0gxYnAzWXNBQm5VejNkLzdvWUh2MEVSTEVoREZ0dnNXOW9i?=
 =?utf-8?B?MENFUmxhQUVzc2ZxVnBFKysrNnRaTkVITnovTHpMODA2K2EzaXhJeEYydENQ?=
 =?utf-8?B?Q3RxTW9KU3V5N0tpTE9rRlNmUnAzOGFYTDNBbEhyVFh2Tk1sQzNQZEgxdlRt?=
 =?utf-8?B?YWVYNWM5YUU1TkR4eVYzQko1RGpBSnFTazdBTTQvSVJtVUtwc2tPQ3MxMzZS?=
 =?utf-8?B?YWdWdkJudHN4ZFpvVnFJd3NBUjBOcmJKWC9XOFplcDRydWdWZDE5VGxtY04x?=
 =?utf-8?B?dk5MWkl3cTkwSys1Sm8xa0MxdjRyc2VhZHY4MGpuc25NSXI1V1VKZFYyZnZO?=
 =?utf-8?B?YTJQdFNpR3Y4ci8wMXJuSXU1VG9JaHlpOG55YVZpSGQzZUV3VTFFMDlvTkpO?=
 =?utf-8?B?Y0U5aUdsc3BQNGU4YU1Ea2F3M0VuMzBOeEtjRDhkVTk4Wmt6ZjlXUFJMR1lk?=
 =?utf-8?B?ZWFKYXJWTnBnaGJVbTJpZ3Vrek5NUE43YWJ4TVdCdXpNazZWL0MzN0pmMlFE?=
 =?utf-8?B?MGNCZTc4a2RVMGdDTE9GNWNCaHVyZXZwWURtZHAxakJVeGFheHRmaUZzc0kr?=
 =?utf-8?B?QzdySUVtM0VNNk81R1ZaTEFPV1ZDR1hURXg4Yk5YRFV2ajI1dWRPcS9qLzJr?=
 =?utf-8?B?emJVV0V3TFZZdjlPc0pZNmcybDZTQ29sNzRCUXdQTmVSYkVyZG9aeitSKzlz?=
 =?utf-8?B?MlQrSnZBZDZvZEozVHlkM0pxc0VBOXJjS1JPOER3b1pyY3JYOGU4MjVRSkp4?=
 =?utf-8?B?b0cwVWdqTlFXRmpFUGk0NGFpVDdWZlZnclNzSjZTdWVMeElPM2tJMDVoU21I?=
 =?utf-8?B?QTJyV1N5ajBnN1VJT2tUOXprdGY1Wjg2RElzdTVQaVc2NVp5RklBbkFBVmZP?=
 =?utf-8?B?RVlBMnJ0V2lWYy9SdVd5NTFJY2d6enZXamZJbnI3Smo4OFo3ZmlGZlJjN3dq?=
 =?utf-8?B?dTMyMW1RdUdwYXVCMHJJK1hRU0hwaGJ6YVlaLy9pNlhyam41Tjd3UjJHY0s2?=
 =?utf-8?B?TkxpYVVXdXIyMVlXNTA5Z2NNMUtHVWV4K3ZYUXEvSnFKUUtSa0FNM2xoM2hO?=
 =?utf-8?B?a2lISEJzMFpCUG9yN3J4MHRXSjFYYXZyOWkwK0VQU3NHSXB1YkMrZGR4aWdV?=
 =?utf-8?B?TVJ1eDU5TkpuZDNhcGZlTTMvRzB3WmFjdjRUako2YW5FOUJZY0VWR2xzRGV4?=
 =?utf-8?B?SGozV2hQSWt0KzBMU2NyYWc4cGhWbzNrSVVGd2p0YVowbmhORnlNVFBQUnFC?=
 =?utf-8?B?cUs3U082STlEdkNDbENBWG5KYjcxZkFKTG0xU1pVZmd4MXJPNWhZVEVTLy82?=
 =?utf-8?B?ZWV2VW12cjZPUHRoMWsrOTU4RGwyTDY4M3N2bGJFdEFGaEtoMkh3dnlVSlQ3?=
 =?utf-8?B?dXgrTFJ1eGs5VHh2clppOXBSRmRJc2NpNTFrQ256SXphKyt3TzF6QmJuRmV2?=
 =?utf-8?B?Z2pvWHhmUllTemVGZVBvNlkwQlBEd0U4anlWR0VrckEzWDZzR0ZteStrNzFh?=
 =?utf-8?B?dXlUZlZRUXY1VHkyMTlSS3ErU3EyUnRodHJBQlRWZVpHdExaUytTbHRjcmNm?=
 =?utf-8?Q?jE09fGOOH2JIsMJ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0D623A5EDC2394AA7CC60CAA8F059F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F4BmAhTOil19nTqZp6I8lmadnQEVr0mBYPbbqaO08M0RP2/mVsPPHurRc8DPDz5J8W0QQRcUp1XWEqU384bEg3x6sd4kOC354mkzrrOK/1ACEL7ohz8QP0bb7bdVqYaE14Iy2m7Q9smWkml8uW9BaeGefZf4BP0BFWc+U+jD6wN/eOqdbAGWS6pX4rLlG+dtMSO5t0M0bku8q5kVNIHvb3mycLgy6Qs1Ivkg0yuK9cGY8rCxr6h1oINF66ZPVvM6YvOkZONpWmmXTckCdfKtQXJkxiirLQUoMGCrdXMM0q7lFqlwmQnPGM3eOfwEU/rX/dRvqIGDaLzsgM/5LbdxTA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802c84e5-1a9e-4252-8833-08ded7049c3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 00:06:33.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7+zA8bxWIw02uViLJPiKjXZ+Fl1VlkHzGirOtDDcOvmkY41n3CMrbgDHvDBqAdlTgT5dk7iBCqim/W1UDka+z58pYNbEZkX7bSNinmk0hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7109
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTA0IGF0IDE1OjQ3ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgKE1ldGEp
IHdyb3RlOg0KPiBLVk0ncyBpbnN0cnVjdGlvbiBlbXVsYXRvciBoYXMgYSBzbWFsbCBoZWxwZXIs
IGFzc2lnbl9yZWdpc3RlcigpLCB0aGF0DQo+IHdyaXRlcyBhIHZhbHVlIGludG8gYSBzdWItcmVn
aXN0ZXIgd2l0aCB4ODYgcGFydGlhbC1yZWdpc3Rlci13cml0ZQ0KPiBzZW1hbnRpY3M6IDEtIGFu
ZCAyLWJ5dGUgd3JpdGVzIGxlYXZlIHRoZSB1cHBlciBiaXRzIG9mIHRoZSBkZXN0aW5hdGlvbg0K
PiB1bnRvdWNoZWQsIDQtYnl0ZSB3cml0ZXMgemVyby1leHRlbmQgdG8gNjQgYml0cywgOC1ieXRl
IHdyaXRlcyBvdmVyd3JpdGUNCj4gdGhlIGZ1bGwgcmVnaXN0ZXIuDQo+IA0KPiBUaGUgVERYIGd1
ZXN0ICNWRSBoYW5kbGVyIG5lZWRzIHRoZSBzYW1lIGxvZ2ljIGZvciBwb3J0IEkvTyBlbXVsYXRp
b24NCj4gdG8gZ2V0IDMyLWJpdCB6ZXJvLWV4dGVuc2lvbiByaWdodC4gUmF0aGVyIHRoYW4gY29w
eS1wYXN0aW5nIHRoZSBoZWxwZXIsDQo+IGxpZnQgaXQgdG8gPGFzbS9pbnNuLWV2YWwuaD4gYXMg
aW5zbl9hc3NpZ25fcmVnKCkgc28gYm90aCBjYW4gdXNlIGl0Lg0KPiANCj4gUmV3cml0ZSB0aGUg
Ym9keSB1c2luZyBhcml0aG1ldGljIGluc3RlYWQgb2YgcG9pbnRlciBwdW5uaW5nIHNvIHRoZQ0K
PiBoZWxwZXIgZG9lcyBub3QgZGVwZW5kIG9uIC1mbm8tc3RyaWN0LWFsaWFzaW5nIG9yIGxpdHRs
ZS1lbmRpYW4gYnl0ZQ0KPiBvcmRlciwgYW5kIGFkZCA8YXNtL2luc24uaD4gdG8gdGhlIGhlYWRl
cidzIGluY2x1ZGVzIHNvIGl0IGJ1aWxkcw0KPiBzdGFuZGFsb25lIGluIGNhbGxlcnMgdGhhdCBo
YXZlIG5vdCBwdWxsZWQgaXQgaW4gdHJhbnNpdGl2ZWx5Lg0KPiANCj4gTm8gZnVuY3Rpb25hbCBj
aGFuZ2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJ5bCBTaHV0c2VtYXUgPGthc0BrZXJuZWwu
b3JnPg0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50
ZWwuY29tPg0KDQpXZSBzaG91bGQgcHJvYmFibHkgcGluZyBTZWFuL1Bhb2xvIHRvIGFjayB0aGlz
IGlmIHdlIHdhbnQgRGF2ZSB0byB0YWtlIGl0LiBJcyBpdA0KdGhlIHBsYW4/DQo=
