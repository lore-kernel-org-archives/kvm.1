Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7273DDB19;
	Mon,  6 Jul 2026 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369120; cv=fail; b=anwKMCaPLhBmYiYbaqt5NxS63FHJgHnz4g9FSfbQ1c8Zcq/uFaJpHXGgecarF2mvf0zfOLrrk7bKQrGRi5hh6mVhv/PgyQEPppUdwAvdroYxKhVexuDGHjwsAcDO7aKBclSI6+hRA77X1LGKhEgUtaQB775nVadeBGplX7K27Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369120; c=relaxed/simple;
	bh=VAiRC8c+ar3FMxoZLmqIQK9lMdOROKNiBaJ6IPr6L9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KwmJN8pu6lvC3IE/l/5HBmoNGAeE/XMmaOTpUeJd4Z31FycSgv7JBTbEukQXUxI/UMrzjWeP/4BKINaoXCkQloJh4VmTV0gRA5vtcfuIfdmNPpxMiZDXID2e7iYtV07QUhLaFOcDVdtbDM6+fPIdlWD9A1isXKdP8eUTLBNFlO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vce3z0Mi; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vce3z0Mi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783369118; x=1814905118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VAiRC8c+ar3FMxoZLmqIQK9lMdOROKNiBaJ6IPr6L9Y=;
  b=Vce3z0MiavVjMe5+IsVHLnrdLkqlatTmgb3uPca2I0t1qaPk23Gli74/
   HPAbutwOIFrMHRJfsKcRsKO6XA2gBMXbxY3mezmE57ENHuG88oZRfhjVG
   JwsTgsKO1kkq+q0/uLq7BnQ3xE7nh6dp68VSeSFA5YmYErXXclStnF8gA
   sU0ltB7KJywvrTTo4l4MhPe0u+QvbL+6uhnsxYBebgeZGzd048GOxkQs9
   Sv00PmAnP2YP5BarXAtu/7GGQD9cOP1r3HheK1oSNT34wpt49UXh6maOq
   MZn/gMMIsH/aEgLo1d3g5OJX8rzJB33IIMk95allUGDJjSOwVtXVfIHPZ
   g==;
X-CSE-ConnectionGUID: WcdfxeFKRbGMWQK9UGHeIQ==
X-CSE-MsgGUID: RKXVMQ4HRB+L0jRPoPpG0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="87926716"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="87926716"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:18:37 -0700
X-CSE-ConnectionGUID: aoI9+zt8S2ykyjRwupUG1A==
X-CSE-MsgGUID: jqTnZ8DYQdOe5rvz/uvONA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="254453248"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:18:38 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:18:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 13:18:37 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 13:18:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuXoIT61ZThcCx7vuZJXENLurrw2Yi3y5CFzdJIywtSIGVLts1cZvw+6QwKiDjE1XkP82JHQ1DlqCcYInxQXL/0YcPX8bRfxb8X2PeRhY7DsHLST5zPclhF75KLLRPCyNckMK+oncZbAVr7BIqbaxds+wUnrc6pmTSiuXPorzzWk7deqKspazuApI3hYg3qpjh9DKJ1+12AKVGfREj/BK+xue6XwVfoX5i1j8zL0jRaPZzs8ITqfSNzClxpCxvzFl9Ov7mZMH+fDC+zb90cszQiaAOARCvM2AkPDOYalokNicoN7IsAOwSNFkGR3dYWsUGMF52IpOruBw5QOAyICTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAiRC8c+ar3FMxoZLmqIQK9lMdOROKNiBaJ6IPr6L9Y=;
 b=RchNVuUk0QAhGyF4opp/G3+ZuPXVhPA1yXMI9X7D6gFwsrIiJGiQR8cwAyBkOTaxc1uc6W2J50jeywJnUuGqU/OPb2a/bE0eXySjKKua/ueRizy/02dZzxNL6/f/oLXEK5Aia0W7pk58K7X7isW7ziqc4xXVkbyMyvbv7YUQAd9JJMYvA4xbFyg80bVPvZtPY9DL1c5J8u2eG9hwDrjcX7C0UvfeMlPJ/APB3eQayzfXRzIpkCw8VSMY28zICwNrUvuiDXkE14Heqck7wjSEahB+IK/Ig0wYY+PPv1vi4PWOngtWeAq/qD3NM/eiCutFeuHs4A8WpPY5fv6fKIxZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA3PR11MB9109.namprd11.prod.outlook.com (2603:10b6:208:572::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 6 Jul
 2026 20:18:26 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 20:18:25 +0000
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
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Thread-Topic: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Thread-Index: AQHc7LhTzhja0MT5tEOwuy4+BJvRdrZbhckAgAWp9wA=
Date: Mon, 6 Jul 2026 20:18:25 +0000
Message-ID: <6605c80fc676c069bcbb097c77c07b17eb3eb97c.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-2-rick.p.edgecombe@intel.com>
	 <akdNPjf3zt6jPX1m@intel.com>
In-Reply-To: <akdNPjf3zt6jPX1m@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA3PR11MB9109:EE_
x-ms-office365-filtering-correlation-id: de26ef7a-4529-41b2-b2b3-08dedb9bbc3c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|38070700021|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: m8YZGoi+miHH9fiA6lrzVflY1Rum0n6/imMSNKecxY0OGErF4jCjijpZUhqh3nXxwP3nQpBcJnJqH5KowfsKmti5LGiN2JUfPjQbqLWapz4ymMroR5+d3Y+FJ5OahNl0KPxNsI5XmfqqDbR699Q+obLXpLwcBEeyYDDHVpNjYnz9BRTZIT6IirYBQku/dqWKXZApRWQ0E6TnJBfuP7p/DsmpoPgRrMpoBTLwZ/7uw4w/cn3jg34IPn7yInbaJH24Y35w0tXu2TDDSiWsE2G9UvtaSDNUHoFhEGJy0dMlelJjJdMIJr/UnGK/mYEds0SuBn0V1p6jKsK4x8cXInTQSK1COi3ooQJfYpenJyvpb1RaPiDcpwLmyCn+1Qf2c1+GXh6J3oaJ/VIviU2IYuatyVtA5L50ka6NF32UeP/XQKq/p5F/S/bGNA7/erGt6ac1NM4w5Wp57qZNrKhpVWXgQlRekyDWUWRZd+3rldme5BLS8/Lt/LXqX2MvkURqMdHoD5d9aUaRRLSBFlDwdZkvVxPoakRqdT21NiVNNOEgAcWRLfdsky9f8xEgSbC55MjlFWhUJwrW5X04wfGhiOqP1mpUFUxmuKVAolrqb3Ya84kF87YIUvD3+CXQILUHJP+Ge/ivVCZ0OISoVpnZEpcW2QBynTbZDX4v57+/U1vkl+MnMIxnIV4FjAQqBRNZcjsHu1ms5T3Rzb7KJqM8bnb7t8iF6h4qs1EM5AOtXDbXalA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVh2MTFiWXp3anNBbm9yK0F6NjY1Yk15RGFaY2s0NXJ6QWQ5ZSt6dTNaUzBy?=
 =?utf-8?B?UEZRTjdDbDAzVVc0SGcrNTFicjI4VEtQNFZiUTZ0WENzT2NFUWkwa1N5c2pI?=
 =?utf-8?B?NXFDUHRjbHNycGgxd2Jja0RuSXphVVF5UnFhVGtPZTkvdkVnV0JMby9DZEYx?=
 =?utf-8?B?TktPbUtZQkdiaFFkeUgxdmJDT0g1Umk0Kzd2QUZBMFdUenVpYlVqQysraG5i?=
 =?utf-8?B?SWt2M1ZONk5kOXpHcUt4RGhoa2V2WmxacGN1NG1KbzBvbFNJaGZOc3JjRlNa?=
 =?utf-8?B?NHpDQkhnSG5LNFJKTWUzbVZ4SHo5QUFPbll6Q3RIK0dBbS9PNHVOcU9oNzJp?=
 =?utf-8?B?dVZXcmhNWlljUHNXaHRrR3p0MnNuaWp0RmFlUEdRZ1lSL055UVowem1GNXZX?=
 =?utf-8?B?aXMzN21rU0FmY2VBRk1RaGJ4NDVIcEpscVJOWjUyajVDYXJPa3lkZk85UHlV?=
 =?utf-8?B?cC9XaDNHVGxIUnYrOFJ3SUhyMlo3bk1wTHZwa2ZuTFpMVUZ4bnVXVzdvc25i?=
 =?utf-8?B?L09pNnIxSDY0SDR0SXQyRzM2Wi9IVFIrcUZ2ZTBhL0pxaXV4NlVpMUFkN1Za?=
 =?utf-8?B?OG1jVXlhUVpvRnord1ZjWXFaQXhsUEtNMXB0YUdSbTZyanNuNVlSUUd3NzNI?=
 =?utf-8?B?MDZDOWk4R0ljMjRsckVyRmZ1WFV3eWZaVjJMOVNFMEtMVEw3c2lpR29rRml4?=
 =?utf-8?B?MEdMUk5DRUVXNGpDWllZeXZPUkZPOUJ6eXVFMUFNaU41R3Mva0dDWjhFWkc0?=
 =?utf-8?B?eUR0alpVQnNiOXRhNUhSWk5NU3RYcTkwOUN6ck9HYmhZOVQvVGVqTlFqNkEy?=
 =?utf-8?B?amxxQ1NBaGQ4OXpGWG5VeGc3QWp0cHdwL0tINmRlUjhmNEkzbW5hNG0zOERD?=
 =?utf-8?B?ODFnQ2pOVExLRk92bzVsdGNMNVFFUGU0TEdWM0k3bVUwc0JmMk00U0QyVVha?=
 =?utf-8?B?V2dHK1lzcHNGV1luaHFOaGlrU0tHb0tGVmJRNEl3dlpJendNSU5UbHR6a0Ni?=
 =?utf-8?B?cUE5SExEMnZVWU0zZkRGVU11cjZqZjhNZlVUUklCVVBQbDEyWE1hVFRsNXhI?=
 =?utf-8?B?MUZGVHhJRU1LQm0xV0s1M1BtRXl2bEdJZ2dTTUJLRGJpY1d0RDlxOUxoelVo?=
 =?utf-8?B?UVJ0Zk9BNkErQktnQkZTYVd4UEcwd0MxMHd3S2xZcTBqMEc2TVY3N2xBOCti?=
 =?utf-8?B?UTMvNHIwUi9WRHdvdkhMN05NN2ZrWm9OdXNBWnZDczFLaExaNk55d2hXYlNI?=
 =?utf-8?B?d2N5L21GQlhNWWVqeGJFRGp6Unp2ZVQ5K2d2TXQ5WHh5cjY1R0hKLzdXYjVY?=
 =?utf-8?B?aUhnSjNlVHozOWtzNkFGYXM5MlF3Z3JXSzZTOFROQWNNTHI3U0FJeURDdmpt?=
 =?utf-8?B?SlFPZDBPNWsyQnVGcWJHS0ZyUHMreTNRY1JtY0FpcG4zT3dZWVJtSlpWNHZn?=
 =?utf-8?B?Q0YzdjBBTE51TFFCSWxjbzVua2NDMHRXeFJ3L1dIOFpWUkd5cGtzTHRhUW5E?=
 =?utf-8?B?bFFYTHpqNi9GajhHNGxheWV2V0dQQkYwTFpLYnl5QjZSdWNzc0oreHpUWlhO?=
 =?utf-8?B?Ky9BSEtScmVMRzE1Nks3YmpMem9ESlN0U0c3SnVERUo4VC95Q3hMbFNTT3kx?=
 =?utf-8?B?NFZjb1Q1eEVGU1Rzd0QrY3VBdTMvZlR6Nnl6L3BTbnRKVHpsRzdzR1VIZFdU?=
 =?utf-8?B?R0RqLzc0YlBkeEl5Rks5c1RMNGhUSFBrSlA2cFlyZzNFRTkxdjRlbHpkUnR2?=
 =?utf-8?B?QjVhZnYyUmpnVFR3VWg1RHJUVDB3S3VDeXh1aUxkcGhWTXZxL3ZScGZmWnhi?=
 =?utf-8?B?UTM5V0tybjFxWHhCbkorRzNRNjNEeEx2Si9MZ1F5a29VWkNMS1I0R05YZlNB?=
 =?utf-8?B?K0VVLzlqUFBXSEFwR1c2UGtUbEplNDdNZXc3dWpGT251YS9kQ0JQZ1dvSTZp?=
 =?utf-8?B?OGREQ2JCaXR1OWdWRTBRTHZ4Q2I3K21GNndtVEdBRnE4dWpDQnZmQWFLU2pJ?=
 =?utf-8?B?L0NJNXVPVklMblFLTTVHRVZMQSsvQTFnazFiNmxHM2UrTXcxVEo3UVIrZ09W?=
 =?utf-8?B?RzhNdEZpWlNlM21qVi9ZbnF4NURqbkpQUkVvcFIycWJxbEFqTW4rNlh4azVs?=
 =?utf-8?B?end0YjRISlpNSFdaNnJtMEFXNjZWRGU5T2VVZTlEeWRrM1E4VUN6R2swYnls?=
 =?utf-8?B?ZzY0TnRYRXdNVkhLemx5NHFSOXlDQmh1SzNGQW1nOWNHQ0E4VVIwc2lqUjRh?=
 =?utf-8?B?ZmZaOW54NkY3MzFJZm0wbENuUFhWYldvZFBiemNaZ1A5L1VwVC94NXAzajlw?=
 =?utf-8?B?QmdRMStiUVpVZURpZk9ISnVLR3E0RE1BSm5VQjdxN0UzS3d0eG1QbHQ3SWQ2?=
 =?utf-8?Q?s2owUUmmVkZVQ0+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC04555489F3A14DB19EEB19308CBFA2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l5PT0UlB4Q6psDFUf4Nuq4difZvb53e75E8kMJxhwwvXuahxR+Beuh5L2V6rXiRgEwryINyqnf/C3F4Cbp+g8IGTHzhsDfRYEFpde/gZUgopDn0KaLQWo50IzQPk8WaHTrOMPOBn03oKdHU4GcOat7xm6Zm0SGYZOKYardP2RVv9HB5Wj3kNxXxpykYv+eDeOCmGtNdPsMjVbvTh7Gele9lYTDXWr/pRg1DfABtDfBdgyps1qQkplQUlu6GCy3xrS/jqS+LAS/ej0N7iMGirsp/GO9StBtc0c1XdF0GedFk587PDCLM6kEebN4CmceUcFNhbslEaIhTnh5x9oT5XQQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de26ef7a-4529-41b2-b2b3-08dedb9bbc3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 20:18:25.7309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fvdzWLsHP1z3WsB7GPtGUKvnLPnEKV2IjQ0sIMnnCl5Ky/oOKchnMOor4WmBQaJCE9zLLSwZ26PvYAw7vKj3PQU07D53Lbb6yg3EgiQgC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9109
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA3LTAzIGF0IDEzOjQ4ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT24g
TW9uLCBNYXkgMjUsIDIwMjYgYXQgMDc6MzU6MDVQTSAtMDcwMCwgUmljayBFZGdlY29tYmUgd3Jv
dGU6DQo+ID4gU2luY2UgdGhlIGxvb3AgdGhhdCBpdGVyYXRlcyBvdmVyIGl0IGlzIGdvbmUsIGZ1
cnRoZXIgc2ltcGxpZnkgdGhlIGNvZGUgYnkNCj4gPiBkcm9wcGluZyB0aGUgYXJyYXkgb2YgaW50
ZXJtZWRpYXRlIHNpemUgYW5kIGJhc2Ugc3RvcmFnZS4gSnVzdCBzdG9yZSB0aGUNCj4gPiB2YWx1
ZXMgdG8gdGhlaXIgZmluYWwgbG9jYXRpb25zLg0KPiANCj4gPiBBY2NlcHQgdGhlIHNtYWxsIGNv
bXBsaWNhdGlvbiBvZiBoYXZpbmcNCj4gPiB0byBjbGVhciB0ZG1yLT5wYW10XzRrX2Jhc2UgaW4g
dGhlIGVycm9yIHBhdGgsIHNvIHRoYXQgdGRtcl9kb19wYW10X2Z1bmMoKQ0KPiA+IHdpbGwgbm90
IHRyeSB0byBvcGVyYXRlIG9uIHRoZSBURE1SIHN0cnVjdCB3aGVuIGF0dGVtcHRpbmcgdG8gZnJl
ZSBpdC4NCj4gDQo+IFRoZSBjbGVhcmluZyBvZiB0ZG1yLT5wYW10XzRrX2Jhc2Ugd2FzIGRyb3Bw
ZWQsIHNvIHRoaXMgc2VjdGlvbiBpcyBhIGJpdA0KPiBzdGFsZS4gQXBhcnQgZnJvbSB0aGlzIG5p
dCwNCg0KT2gsIGdvb2QgcG9pbnQuDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBDaGFvIEdhbyA8Y2hh
by5nYW9AaW50ZWwuY29tPg0KDQpUaGFua3MsIGFuZCBmb3IgdGhlIG90aGVycy4NCg==
