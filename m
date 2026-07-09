Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1E1B4223;
	Thu,  9 Jul 2026 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560142; cv=fail; b=RsdF6CZQKv+ShdBi72q+l7x9mhBjA8bbjisY52kR4fUtkBktvgo9t+gtUz89LuGIGdOtrscLG9jH2XOXFd9VUyw+JuxVpaqF3fOeuRJ/R/rXgL+khIkoGlnKGnxyz2UQQkaQcuW5zub6A5rDfEF/iFy5YDO0pRLWbeJ9Tp5o5Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560142; c=relaxed/simple;
	bh=+XyUKE+cSWhEM29DjsGkEi7lBaH0OSxed+NXylMSwRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mpeJDJS8GLtV+8HkCJv8pAB1NKYJEeY+kYE8Lz860JftA/v3ak2OcQUGmXlQqXCtVRwUrX5Jc6AM9ADlmd6BPuQp446cE/7r7RYBkjdyTVRwwRzHt7WJ4Bl/91+UUMEx5hAKQSX54bLPPnTHcaMVMXb13WHVz28b1lxaQexGgBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBjO1+zP; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBjO1+zP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783560140; x=1815096140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+XyUKE+cSWhEM29DjsGkEi7lBaH0OSxed+NXylMSwRQ=;
  b=DBjO1+zPozgAuxAbUk9Mk4nNq3USPap9+6ac3SxvpE8UFJJSMSQnMizo
   tIbHQtjY6FzzFPNgOV9aJGkvj+tRVuG8ArYk3iEJgD9FQzKvkyoPLbkXs
   7Mzl+RR+SV2Qm35IjEb3hg3VNCi1Q3gkT8Q7kK2kBUmL3avl5XuraQA5D
   SSUg+JO2VAMuEtkma5M4tFoUmd0N1goKlSeecxGOYrTaUP74Fx98PO57l
   fAsc96+l7ZPw6igg6jIKjJn2YaFdcPA3A2qSr3bPs/C9ynerTLHBRlEvc
   6YzEX9FTMiEG64rK52lt061TcEPBwyd2AbZbA4g4mqmrHSlT+ujEEPKmL
   Q==;
X-CSE-ConnectionGUID: SjAdMHR0Q/WUiBkLSCVCkQ==
X-CSE-MsgGUID: AdhmMT9LS6SfdyTfXH1d5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87921616"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="87921616"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 18:22:19 -0700
X-CSE-ConnectionGUID: 9tGJP7R9TBKe5gxJuFur9w==
X-CSE-MsgGUID: 3mCI+6jGTDSnljbM+Jbp3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251787845"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 18:22:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 18:22:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 18:22:18 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 18:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcczG5FaDC9aG5WXqwNfP75bZPFLwD2cNTs3C1jOl/BmkLNZSy+iKGlzS8tmIVi3cr1IGB/Uz0dmq3dPtZGyF0UZpu95mPsbWaW4emjyZ72YcdroTvyAXNi+K7/Kov7zcQGijlx9PD19wNIAGhO1xP2YsF4EvTOxXT0EqvTBossXlFaKKe6iF2kdBwWkPnR8KUZcvrsA46ytmFAvB6hgP8DUFzDPG7yYexq8t6ljq65ckTYjuAQbrYCecRrKb3YbNSSKujHvL80Dre11SorVJX9ViSlkID4pZI/BBFswaEsqaXsEGsW4d+rXEmmLgXSzGESb1yieUnGpT/VKlBrOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XyUKE+cSWhEM29DjsGkEi7lBaH0OSxed+NXylMSwRQ=;
 b=tN65Tm9g5MkMPp5ufIl5Qj5cv6O1qTqDbgPAIyYPVI96lq9rbqJFFDG9cDnW88QQ8Ct8JdjxdVvYOzZMbEAazLv3Xu7fpBUaYHy2GSZSiotC69wnoUt8vxhC3eWyLd/Fi9HqjxzayHQcTysXsudkerOzUVsYv7nTPWZ1nFVkmRcby0gd7pAF2fO0yABXZ/gVO3Ap4ycGrl0YvAiTz+mO+Sj/MECaTQoIoCLW8PAVCBVMbgwx6kqMEzWVq8vsUgRBlnwwuCltqOqpTTB63iEGgoUA72DM077YDxOx/+s0fPY/wLJ27P8dIUFoELndemC+EuUtzG9T7U/ed089wcS0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB5888.namprd11.prod.outlook.com (2603:10b6:510:137::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 01:22:15 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 01:22:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 09/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v6 09/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHc7LhX9RO+2pRq0U2tIIZKWA6Q3bZjj/CAgAEZWwA=
Date: Thu, 9 Jul 2026 01:22:14 +0000
Message-ID: <2e5a6ff96782a7e3e5de14c9967211eaec48010c.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-10-rick.p.edgecombe@intel.com>
	 <ak4Lv+CQIG1P3k/f@intel.com>
In-Reply-To: <ak4Lv+CQIG1P3k/f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB5888:EE_
x-ms-office365-filtering-correlation-id: 1c3e61e6-43f9-49f6-9f61-08dedd58823c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|38070700021|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: q8c2FG4TPbyZLXw5TyHhuEEAnUU7QrEp+u/p7aCVJfZQKENL5JKsXsUz2tYQPPsVJieIrvDht6EJbt0O0k5vQVbPQxqCFuUPfXue4ZbtaitqIDK+RE0yEM5yuGRr5XiORV32AnfAcO6Oar7f/+SqH+IV/8qJiLWb5GVtGkP5ITSx9eFvzqDfHChTS0QkbeajGa+PvjOzjNCpYbczlcNJFsmKOpy0aX0iEavbpltLooLTnpr9YhyDw+pbZTA/MGGl0qxc4KI+ATUoGoDetQYVsTSx9DDJ8472JLhL+2ZIPrAY6ri9U56NHnIU4d4m2wYKC5ivJFBMY0nHfJYc6hzCk4PZ2CxViDyY1vI/hV9G560Zd8M7PFxFHGq9jzEHT1Y7wM79cOPDJ9mY+Gjhoyey7yl5lJ+ppgxcHk2Vs5qBBnk/jBMv8/DAczT3oTVN/CAq/b8uV7ny2gF6MVoXUhy7Wap7d1iqCOhbvJGQRnhb1cGP9uVR38OZrCItHUGRthkHdKshuRaWfecc2dlc5wl+1TneyUCex1tFP5gNQVYcqL1GbP57aVULxUyyZaq7guc35tv3RG9szT36jEnUDvfiaMu4wIfeqNvVKVGWMkaC9llHFSzC94PPFWW13cjkkrD3toHt+GP+e0gTnJfrsZXKNYGwTBgWSQArwm5xTfvbILtKg1eaF62U1LCyWx8/Xhsh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TktKUjR2NVRsUGZoQjM5NnUzTnhLUXI2NnZHd0YwUFpMdW85YTI3am9leGFr?=
 =?utf-8?B?VXdTYUw4ZnU4SzJXTTV0NXdZUmRJYk4xQlRKUkdJR2VGb0xGTEVQSDJneEZK?=
 =?utf-8?B?SUlUMThvRjN1U0FvOVl0cWdZYTduZk42RVA2dHlmZW9YVmRQYVNIU3NDSFVC?=
 =?utf-8?B?U3lmQzM0dmdROXVoNjNqRXdSYmZheWJwMHJTRUk4aDE1M1d2ODlBcHZLZFl1?=
 =?utf-8?B?VUN2Y1NzNDFTdEdZVmpUTU9WQVdoakxjRFNTL1BmMlp2VzArR0Nhc0RoN0V4?=
 =?utf-8?B?VVVZRlNTRHhza2ZLQXNzUWY5d0ZpSEdOWkQ4T0I0c2ZqUGdtam1JQnRzcmJ6?=
 =?utf-8?B?Rzh5SURiMStPSWcyOXIycEx5YXNJbXIxdmN6ZFIzZmNTZzhoaGdJRHROMmsv?=
 =?utf-8?B?NEVWcjJRKzJFUzhTTTBPZDN2b3NNb2Z4SjZrcWQ4b1dnaGNCWVhrWUZWTm4r?=
 =?utf-8?B?VWNRSEY1ZVlOWTJYU1R5V0NUNnlMaWdLNW9Wb3ZqOUtmamsxTGRnKzQxNFY4?=
 =?utf-8?B?QXlGZGg2cUFwbWhPVW5ySzVobFRKcW55VTdnVlJpRUJjY0EvZlROMjh0MTQ0?=
 =?utf-8?B?ZWR4QUVuekw3N3BMQkwwSUsrazFrNXlJQ2FhNzYxakRMUlY0UFVXZEFlQ2JJ?=
 =?utf-8?B?NDhVVUhLRXhSWHh1Nit4aVprUThoK0VpM0grbENyUUYrakFBRFU3bHdXMVhD?=
 =?utf-8?B?MS9lU1JNUTZzWUx5WnM0ZEN1eFFhVWdLSU51aDJxVWNUeXBqSGRXSEh6Qk1G?=
 =?utf-8?B?eS9Ob1FnTFQ5WjE2bW5RbXhiY3FhUXBPSjZrRHBQdFNpZ2g5NFNCUlp4dmNi?=
 =?utf-8?B?TUlHZEZtYllXMjZkVW5JcnhHVHJjN3gzL3c3eWN2TGYvbDRGK0hTbjllaUZO?=
 =?utf-8?B?ditWQ3RHMVNhTEV6aklXZE1reit0dW4yOUJtaWpoVUF6aGN3aDdtQ1YxcnZz?=
 =?utf-8?B?SmJQMjBza1NxRFo0a2c1Wm1BY1NWZTUzRDdwc1pWQVJEMmFEMXh6SVVNNE5K?=
 =?utf-8?B?R0ZibDFvQ3d2STNhQ2dMTUU1My9BUmFYWXBoOWdKV2xlL2lFY3dEelVJTWp5?=
 =?utf-8?B?bmRnb2FQekt4bG5qZ2xLSlRYdExSVW9RK2dKcXBhSVRZZG9mWDRLZnU1ZkdC?=
 =?utf-8?B?N3FUNlZFTURsWXI5THpubkVGUlhYTDE5SWQyN2s5OE1kR1lkQ1NFbWJvQWhS?=
 =?utf-8?B?Rnd6bVArR2VzcjkrcFM3eTdNSDRvVHl4NTE4c2JzUDhIazZvbDlxa3JTRDN3?=
 =?utf-8?B?L1JKd3VDeXRhVkwxR2ovcjVITjVKVWRKNkQ2N1gzc3BFdjNPVTJGYlovRVA3?=
 =?utf-8?B?THBGcmhYek5lVUZxbHhtd2VCYng0MnF1YmRaZXNMMUtKWitJdEIzTzhpalJu?=
 =?utf-8?B?OVRwMFZaNG5GeG0rUXJuWWVtTWRwYmlIMjJXa2VJL0Zwa2FUelBZZE4yeCth?=
 =?utf-8?B?dUp6M0FOSUNRNWhLbHF6TTJSSS9Dbk1EV01aaERReitCS0dvSFhZZmRSRFJz?=
 =?utf-8?B?OGUzWlNiVC9ROHZwM2NCbDVoK0tMRFo0bUFQaHh2aFZOeC9Sbm5wWm4xQmpE?=
 =?utf-8?B?YmFNYzQrbWNxKzZ4ZmZ3VGZ6ODF2WFp2b0JrVCtFZWhuOFF6QTN1anE4QU5p?=
 =?utf-8?B?QWh3NUtGZkJTYTVKY0hrZkxHRHpKRlU2bm5JNmZFc2tsMWhNcTd5eXNKdUpm?=
 =?utf-8?B?STVRUnEwNUc1QURlTEtPN3M4YjhQdTFQV0dVT0JrLzhqcVh5alZhdWZTVmdC?=
 =?utf-8?B?b3FyZnkvS0R1aFRqQlpIV2VubEh2OE5uQloxSXlHakVLQk51ZlZmME8rcnMy?=
 =?utf-8?B?dXc4a0RmT0RySlJyM1dBS2NGdHV5SkJpN0w2QTQ4NW9KTkp4VDdiUzdEeWFL?=
 =?utf-8?B?Ui9KdmtmcUs0cjVpdGdEUlZsaHhlajFDTjE3SjFVeXg3dmEyUUVZQVhYdGMy?=
 =?utf-8?B?WnFxQlVRM09DVTVTVUNJMFdESnRwTDc2akdud29sY1hrS2hta0llSVgzYnl0?=
 =?utf-8?B?ZTcrRHFpTmpSTGR5bnFJakVmeUdEd2txSkRrR2pHc0FVQ21IeThJRXZRQjdm?=
 =?utf-8?B?YTJBdWNyMEdNR0MvWGtZbkc0Z1pxTVBoY2V2Vk5tZEs2QzVsQ3dBbU1rRFNR?=
 =?utf-8?B?RDRUS29QdnZOM2VCSmpiOUcyWmc2aWdpQkdJTEdIb2RBYkNUcS9PVFpvYm5I?=
 =?utf-8?B?eWIvWUFmb2tCNmZiUWRQc2crZFdZT1lFZ2dOL0JsbG9Qa0k3L2NGK3BKL3Qv?=
 =?utf-8?B?cWhNWVIxWFUzNW1iUi9uYTRKS2wycmlUQXE2emVkMC9oMEh5czQ5TGpsbTNx?=
 =?utf-8?B?Y0ZQTUNxSSs4SFVrYWd3bTRWaXFJcGpjd1ZUMTZxZkw1TCtsdGJBWkpMbkhr?=
 =?utf-8?Q?/coZ5FGUQfbbMLVg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08697C605079E6478053B11C9C44E334@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HyYyjeKSSXc2jlTzvxwYnoSqIErm6V7R77v+qs6Jc6ibH2LS5cTJmnsNnQfpSHOP4nDQZOxOcVuWNKQwiHH9hgLYUCtO6casZeCa+pBv/MliRSqnrTU2f8k6S0lIdZQQ4fTUMYuoLO/a9/WF7kZANTHdcSGni36+E4KNt9qlUOv7cYhoe1q80bHW4zUFWyPhnxjkcAbREowq7YmX/0l5Hc3TnNaEOOcl/E5WMuA5j+4Eg3IUIvmpajDgHnF40JeCWhsrqB8ZKiq3AJsX2p3V+KRQG3yC+D+X8WkWxxO602vASgDn+v0FDFzcnXHjhGGeb02jAx/gIisB4xWHevymug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3e61e6-43f9-49f6-9f61-08dedd58823c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 01:22:14.4941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRi+F6wdJ+zDZYxTIaRhFTE99C5v6jCfH7lQlQN4xmiEnedYxpyXluAjfEVCdNbQQNHOSi7wRuzwk+cpbDZ3Z5NgRAK6aPaQ83yAW2ftgfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5888
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTA4IGF0IDE2OjM1ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT24g
TW9uLCBNYXkgMjUsIDIwMjYgYXQgMDc6MzU6MTNQTSAtMDcwMCwgUmljayBFZGdlY29tYmUgd3Jv
dGU6DQo+ID4gRnJvbTogIktpcmlsbCBBLiBTaHV0ZW1vdiIgPGtpcmlsbC5zaHV0ZW1vdkBsaW51
eC5pbnRlbC5jb20+DQo+ID4gDQo+ID4gQWRkIER5bmFtaWMgUEFNVCBzdXBwb3J0IHRvIEtWTSdz
IFMtRVBUIE1NVSBieSAiZ2V0dGluZyIgYSBQQU1UIHBhZ2Ugd2hlbg0KPiA+IGFkZGluZyBndWVz
dCBtZW1vcnkgKFBBR0UuQUREIG9yIFBBR0UuQVVHKSwgYW5kICJwdXR0aW5nIiB0aGUgcGFnZSB3
aGVuDQo+ID4gcmVtb3ZpbmcgZ3Vlc3QgbWVtb3J5IChQQUdFLlJFTU9WRSkuDQo+ID4gDQo+ID4g
VG8gYWNjZXNzIHRoZSBwZXItdkNQVSBQQU1UIGNhY2hlcyB3aXRob3V0IHBsdW1iaW5nIEB2Y3B1
IHRocm91Z2hvdXQgdGhlDQo+ID4gVERQIE1NVSwgYmVncnVkZ2luZ2x5IHVzZSBrdm1fZ2V0X3J1
bm5pbmdfdmNwdSgpIHRvIGdldCB0aGUgdkNQVSwgYW5kIGJ1Zw0KPiA+IHRoZSBWTSBpZiBLVk0g
YXR0ZW1wdHMgdG8gc2V0IGFuIFMtRVBUIGxlYWYgd2l0aG91dCBhbiBhY3RpdmUgdkNQVS4gIEtW
TQ0KPiA+IG9ubHkgc3VwcG9ydHMgY3JlYXRpbmcgX25ld18gbWFwcGluZ3MgaW4gcGFnZSAocHJl
KWZhdWx0IHBhdGhzLCBhbGwgb2YNCj4gPiB3aGljaCByZXF1aXJlIGFuIGFjdGl2ZSB2Q1BVLg0K
PiA+IA0KPiA+IFRoZSBQQU1UIG1lbW9yeSBob2xkcyBtZXRhZGF0YSBmb3IgVERYLXByb3RlY3Rl
ZCBtZW1vcnkuIFdpdGggRHluYW1pYw0KPiA+IFBBTVQsIFBBTVRfNEsgaXMgYWxsb2NhdGVkIG9u
IGRlbWFuZC4gVGhlIGtlcm5lbCBzdXBwbGllcyB0aGUgVERYIG1vZHVsZQ0KPiA+IHdpdGggYSBm
ZXcgcGFnZXMgdGhhdCBjb3ZlciAyTSBvZiBob3N0IHBoeXNpY2FsIG1lbW9yeS4NCj4gPiANCj4g
PiBSZWxlYXNlcyBhcmUgYmFsYW5jZWQgdmlhIHRkeF9wYW10X3B1dCgpOiBldmVyeSBjb250cm9s
LXBhZ2UgZnJlZSBnb2VzDQo+ID4gdGhyb3VnaCB0ZHhfZnJlZV9jb250cm9sX3BhZ2UoKSwgYW5k
IGd1ZXN0IGRhdGEgcGFnZXMgYXJlIHB1dCBkaXJlY3RseSBvbg0KPiA+IHRoZSBzdWNjZXNzZnVs
IHRkaF9tZW1fcGFnZV9yZW1vdmUoKSBwYXRoIGFuZCBpbiB0aGUNCj4gPiB0ZHhfbWVtX3BhZ2Vf
YWRkL2F1ZygpIGVycm9yIHBhdGguDQo+ID4gDQo+ID4gQXNzaXN0ZWQtYnk6IFNhc2hpa286Y2xh
dWRlLW9wdXMtNC02IEdpdEh1YiBDb3BpbG90OmNsYXVkZS1vcHVzLTQtNiBDbGF1ZGU6Y2xhdWRl
LW9wdXMtNC03DQo+ID4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwu
c2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiA+IENvLWRldmVsb3BlZC1ieTogU2VhbiBDaHJp
c3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2VhbiBD
aHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBS
aWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IC0t
LQ0KPiA+IHY2Og0KPiA+IC0gRG9uJ3QgaGF2ZSB0b3B1cCBvcCB0YWtlIGEgbWluIHBhcmFtIChZ
YW4sIFNlYW4pDQo+IA0KPiBUaGUgdG9wdXBfZXh0ZXJuYWxfY2FjaGUgeDg2IG9wIHN0aWxsIHRh
a2VzIGludCBtaW5fbnJfc3B0cy4gRGlkIHlvdQ0KPiBmb3JnZXQgdG8gcmVtb3ZlIGl0LCBvciBh
bSBJIG1pc3JlYWRpbmcgdGhpcyBjaGFuZ2Vsb2c/DQoNClRoZXJlIHdhcyBzb21lIGRpc2N1c3Np
b24gb24gdjUgdG8gZHJvcCB0aGUgIm1pbiIgcGFyYW0sIGJ1dCBpdCBnb3QgYWRkZWQgYmFjaw0K
aW4gbGF0ZXIgZGlzY3Vzc2lvbiBhbmQgcmVuYW1lZCBtaW5fbnJfc3B0czoNCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvYVlwcnhuU0hLSFV0azdwdEBnb29nbGUuY29tLyN0DQoNCg0K
