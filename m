Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BD390987;
	Mon, 13 Apr 2026 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109257; cv=fail; b=l1+RgC6VMjfTIOj0+vLsyUooOHeQdsA/1MlqewXy+fAmpXqKv2CNxUwubeFXumF+L/U5O0dEuvCVMhdc0NpmBk6vVHFeCOmPFKbwHPJUafDM1dWN1v3gWLRN58UmCn2+7BQnApn3u6p1kEhFNnN/7am7w8Q7T+oHzVN4FdcRakw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109257; c=relaxed/simple;
	bh=/1KUL+O/CZ4M8S0Jud3KnpIT+Y4PoB+/YusyS7Nla9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=inCgZAU7I4Ju5zt5ogAEk1q14ANSXDAMQUlFXEaajNq/BupjRp5wjGFuaV5pHtR2XN8AgTkDnrgwQOo4lnSp4xH+rPlF+xNPI7CojQxvQREGV+JjiinWyLcWuissVcfpVsjBYKIrotRN7NHtYwvGqdvx7XsuIESoKxt8uEbbtno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTxDy1oF; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTxDy1oF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776109255; x=1807645255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/1KUL+O/CZ4M8S0Jud3KnpIT+Y4PoB+/YusyS7Nla9A=;
  b=VTxDy1oFceoQlHe1aEBEq3sFh9BqxIriFnizS1pktKS07TVta5kp9c3M
   htkvZc0IkJX+yFRTy86sWkFsOUU6lgmCPn+NOQzpkVbSejzntDCtXhS4t
   J4pqFJHKzEveifcnLRx5uG1IcE6yuBkRDwl+4PBt0SnLYP8ufbJFrp+bT
   IOxeuFBxr/W/Qg+eZzxrSCr74leck0XMApCzZZaB4BiY/yf4TO6vzzR4c
   tZSWiBFu6alIst14jTQF4xSzplOLmY4L9vBTFlktP7s/rFXEUVDFYucPB
   xizax+Qaoi8kNjcl3wu7l9cgoBOCTo1RpSRvyBZUPTvIrmU8C3ccEkefW
   g==;
X-CSE-ConnectionGUID: WGWh+B1CRXu8ulZJhJO7Mw==
X-CSE-MsgGUID: UdCiPrgaToafWIlp2MYB6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76764386"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76764386"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 12:40:55 -0700
X-CSE-ConnectionGUID: bGeAYxgbQpCVUk7nF/8Byw==
X-CSE-MsgGUID: XKy1ekIaR4uMxdpm4ORIWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="231606810"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 12:40:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 12:40:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 12:40:53 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 12:40:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bO6aCtrgHiDXMHC56SW01Aj6VHsVlfDQcjM4SYiXhOKLeGnng0p+BPbVsNAez30i2lRWCBFZCtGxQnypB2h+hFnwQ4+VjJes6pNnolFfpZIfOtycIsXEi+E+u0UIS+P7epZWeEJbyvqL2qiUqvKtaZeGWlDoMow0IZLc3dGQ1qVr1jwcai3NlYxfKk5p4Pph3BQd41qquK7Frstkz4ipkCFFOGpi/Kw8kkFajGZCMV9pj3H2MvsMBzqquTGTemU8cBZo8pRlfDPMMF+rsCALLe6YFXUJfv9r3y9HveLN82lWJo+VpIkYwg0JfES1i7ijWs/MsfptVIApiKrhrc5D1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1KUL+O/CZ4M8S0Jud3KnpIT+Y4PoB+/YusyS7Nla9A=;
 b=YyD4cy7mnunOQvfw+ohArKYa8lY3RTe4v7M0jzuuFWswAiNeIYefnX0k0GNtP07byHZKPJBsdOdUwRYrpHjtOVNkIDxCZM+M+D+fzVsZgpa2GfxmkL/VVReVBjaRT1/Jr4nBNylXHrOdsSggWGQGU6PFzh0a5hJHpTGLvoOf5AdfHLvbCZIJ5uIVzY7Fg3D0U+PXZhHL5dq2cJJ3S8t+uVNrYuyiF33NmDaNYh6CZ0MiuE7CaEq42Yze8DYVMMTx///Gwm7oWLMOdDqvGD920GKTCSNDTnnxmNmz03eyrweHx07X4TID8XArnKr+5hcgs4m0FpP6RVit4nR/bQ4OKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6906.namprd11.prod.outlook.com (2603:10b6:510:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 13 Apr
 2026 19:40:50 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 19:40:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 19/22] x86/virt/tdx: Enable TDX module runtime updates
Thread-Topic: [PATCH v7 19/22] x86/virt/tdx: Enable TDX module runtime updates
Thread-Index: AQHcwQwH67K1xvNwME6nRH+s4p3Rn7XdeMIA
Date: Mon, 13 Apr 2026 19:40:49 +0000
Message-ID: <e908d5c5199632cf694282b4f2d1736b5523b8da.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-20-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-20-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6906:EE_
x-ms-office365-filtering-correlation-id: 5e5fc546-cc76-4280-469d-08de999490f2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: KzpjDRgIb60DmWMSVw1K/PSiz1p8RceKKvergkiAIwsReDUrTGbANNiiPmbTYcklEXQjtiSwV5W8G734yrEQ3zkSgR5FRXMQJRC+k5a1ioG26TttFTD2yzd1aFGhyYpdPytT0qdntPaMOCvrFJbhoTY5W2wLwfVkoIyICWgNOrjQGKhoFpbtsP6V0AdXli7coWtaVEKJ9dSPcryU1RFbQs76uGV4gjun938KKeLpDPSQAhsT4qQyeNNBz2Zx8jG7z9zS29a2wyYQ3rbq72l7F2y13mj3O3tfQaR4ZM3gQMYmmDZ/S3hFfJKUoJg4f4MPv7eGBtTQEqRziOfxxj6ptddDmVFGVZ1nTquqabl9bG8tKmrIsOLbtN0fmfekI06Di2ZvmX8i9FOUmALPnXnS7oh+uRGe4ulT/HVVknB+sns+GeNu45P5Mwd/gNxyOc+1D4cNkopYVerpQGZ4LIebF0BRCrZx1UpiOQyHbvtlt9gomQ9RbuvV7aPeGcaiK5E8U5cbUPtRFNdV4rbrrocqYDx3HzS4WrerottQeR48k1LXO3tsqMnFpACVt6vU1/z86P5w7BFuT4Eg+ULaKCZeoHwqjLFpov4NhSynRTXRhOltFYIq4mqkNYND/DTGTCMOtewhHgCP9GRp4qgg/weMWgvb0cWAj4lF06jwB+S57HhALdZx4EBVV+hwvoYxg05QR1v8Oz3UCzb6h+stN25qaF0L2EW3SwtKJvlo2ghalFcoT8Ywy0yuH+GaB9/bKZyOmS4qgG1kv/+a+PLcdx7Baf9/ZD0v13/m0CYBHEA60/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkVBOHZPeUNpU2R1UUFJUnZMZ0pRWTFiWHFjZmxycmJqdmFzZjVEbEkyRk83?=
 =?utf-8?B?OXNCNHJQaDZoNTBZUVZtZy9YSnRuZjlsL1JhNXRPMU83eEIrUUtqM1EycTJz?=
 =?utf-8?B?UmdCOHhyaHh2aGdKbjZxNVlvbk5Zc1ArR3lkeHIzV1F5TFVnK3VObEE5cEVn?=
 =?utf-8?B?MC8wTEJEd3NQNk1vOVFJeHpQeVl4REV6Y1FQVkE4RWFxejRZbVVwdGY3dU9z?=
 =?utf-8?B?bHlxRXZtQyt3bmNpbUg1M0RIMVdNZy95MnhIZFRWeUppQU0ySmNPcTY1dHEv?=
 =?utf-8?B?aXVKRDY1T01oMTM2c3Z3TUl1bWtWd05Ta2pIeFlFb3BwbEY2aHM1MnVrYVMv?=
 =?utf-8?B?UVlVeWNjL0lBTVV5ditNN1JoWTRlVjE4a2FrOHRwK3lrWGNGMlZ1QWJBeUdP?=
 =?utf-8?B?RnByVFdHbTBTT3FhMzNYSElHMmREZkZFVzUwekRNaXh0OCtyQ0xvakgwOTNU?=
 =?utf-8?B?a2RtWjVuN2dVajVkS1JSM0NLdDg3dVlmS2t1Y0svYkY0aDlNWUxKQ3JmZkpE?=
 =?utf-8?B?MDBjenZjZTBSTVlOdVA4UTlpVnBibzdDaHYvYUw0NjloYlI5MDJUc29iOXBW?=
 =?utf-8?B?bW1mdHU1WndERnBsaERDdHd1c1FSazAxVVdzdG9HbEdIMnV2cVhscVZLbGc3?=
 =?utf-8?B?c1NnUWxnbGhKK21vQXlZVG94K3BoTEEzWGdDZzFZRE80SXhvUDVMN3JVZDJq?=
 =?utf-8?B?UzNxSzhVeWtPTys0ZlhtTG5FY0JLSTBFWStVYnF2Rkg4NFJ5SVpNdG9PVEVU?=
 =?utf-8?B?dmhXN3FvOUtLemh0SHY3OXdrbmhsNnRaZU13UDIyMHFjUDZPY2d6Q2VlSTdY?=
 =?utf-8?B?Wjl0QzlOdS9SOFhhdVFZbkQvcndDRW9BUkd4YzJQR0JGbnF2K3U2RU11QVhj?=
 =?utf-8?B?clZsZlRiRExjaUNvS0JrM2QwV041MkhRSjd2RVV4UFNDWXMyekVJNnMzendX?=
 =?utf-8?B?TGdTL0owcC9zR1l0c0l3c3R5ZHZqYnl1dWwwcGUvUEVEVkxxZ3dSRUdoblIv?=
 =?utf-8?B?a0xIb3Zrc1pjY1lIaW91S0d3TXIzVGM3Uk5YRCtRSU0xQzJPTXlabUxMZzR0?=
 =?utf-8?B?YVNDZFV5Mm96QVhjZ3prLzBIODFVOFdhNkR0ZFRCdGFyWjZXVEhoVnFyMUJj?=
 =?utf-8?B?UUt1aW5RZDFMcnU2eFVQUGJoREVZakNwTU0yS1psb3VqVzFnYXlBbGhkaFp6?=
 =?utf-8?B?eThqV2d6UW1aVjBZK2t4djc3MUhzbWdYTDBmQi9vRW5VOE1pUjcveHUwTCt1?=
 =?utf-8?B?MkExcEVuTEJHZ1B0SEpiMERONXVxaEFPSUNucHgwdXZEcVhWa0hZd1lFdHVR?=
 =?utf-8?B?dHdYVUQ4UWlKZEhzZFZmT3hHbzZlbmpGNEplTDBSMEFtZG9wTVVIQ3dZdS9i?=
 =?utf-8?B?c21weFR1Q2tabm94aE1nYkF0aXZqWWxNbGdxVkNxRkJaSUF1eGtSa21WNzZ4?=
 =?utf-8?B?RCtUZjZSRnJYWGhRYVpwaFliMFJJQnl0VlR2VUxtUUMxZDdhMlR1eVNNZ1dX?=
 =?utf-8?B?TU43M1ZGOTFoaUFySnUxZDFBY0Nxc2ZXMDBmU2V3dlYvcnkvZlZldUFHNFlq?=
 =?utf-8?B?ZVJ0UjEvZHVTYlZid1YrK0RicVZDcGVXOVB6R09tSjdwTzBwQWZHUVJBNW5l?=
 =?utf-8?B?endGSzBodWZuRkY2bU9PeHZmZ24xbnBnWmdJc3QrSVdFMUpnK3lmRldnVXFq?=
 =?utf-8?B?SUtMN2pXeHNER3ZQcDlwVlBiWGtHYkdtUUVrL2dYMzBwWDM2ZHg0WllaYmYr?=
 =?utf-8?B?MWZlVUw3VzJBSkZmamZEZlNRWEJ3ZWdicnRQNmxueWZSMGVIMzJxN1ZLeGxa?=
 =?utf-8?B?NzhRcFFzTnVLckZacGlpTmxKbnplQUdINjZic2dHb3IzSTZCVWVxK2kydUpw?=
 =?utf-8?B?eXRkR3VnaXpmcG9qcFRhTjBlenUxWmNoc3p0dnJKRWFBNGtLZ01GT2lLRXdh?=
 =?utf-8?B?dUdlQ0MxVG5FMjNudmNhcExSTXVtV1llZG5QSTdmKzdCRm5WaFhTUjRLcTBU?=
 =?utf-8?B?ekRKenBPVUIxWHduNEZwS3JrMXl0V1pxODRCOU0vV2hCNFlIQmppTjZkRGdy?=
 =?utf-8?B?dFQzYnN4TmtOR1d3QlMxK1k3T1k5V0dKNnpPanIxTTVaWUhMWnMzcEUySEo3?=
 =?utf-8?B?TGlEZDVwY1lwbzBNRm1OS1h4Q2tXdDRobmhBeEdjKzVrQy90WXFlbXNvNndE?=
 =?utf-8?B?N0ZJUlZwOU1LMENhS084emVKWVZIS21WREYyclFPTGFya0lmenpKRDJJeTYr?=
 =?utf-8?B?RDNQWk83OURpZWxPSTB0cjhVVm5NSDFzTGFBelYraGpQNk5vYUtNUjViVGVM?=
 =?utf-8?B?QzNyUi9FajQzZldVR0Q5NVBCcEhJcys4dFRrMkxBOEp6OTArL0JSTGUzekdx?=
 =?utf-8?Q?L5d0yfnZYlv8Ap/k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <580733BB88E599429F6D25CE5C15BB50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GdgxmNVGB2J+lylUTg/ILNTjOY9JIRmQTKhoK0P1Who0M6UJO5IqxeFCAEpx+4RdzWoNcUucDm2QkrqI+5xEWlxQkx/0fWXc0Ps7rQXKjlqizx1qVGjsksMpRm2lR6hc+nyoE1Tvs60hGMZrdsInQ4M/r+LP6Pjp/EZEgPhFsQFTTzxJRykPKyjtvXaHLft7AQeyjJXOHCP+xLQ17ihrEXFpoxIJVLBhFrd6S9WiSjzrLoyhpj4TbAxCQiTGBl4r8Uahg8hQW258Prg/sjsDCHkI0vEpG3laBg7x+1omuzJjYX1lSdcAJUNF5IYUGe9sqmf500AiP8z1RUeBR0yEVA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5fc546-cc76-4280-469d-08de999490f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 19:40:49.7779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilzdjdA3/RCT3xebKQFi7nvcjMw8DtZA1nmZN0jGALBSqmvpXJVvHqzC+0ve2rMsdQFaYObBDkhMS3Y44Htgvz0azeEAkTAF1J30Gnikbes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6906
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gQWxs
IHBpZWNlcyBvZiBURFggbW9kdWxlIHJ1bnRpbWUgdXBkYXRlcyBhcmUgaW4gcGxhY2UuIEVuYWJs
ZSBpdCBpZiBpdA0KPiBpcyBzdXBwb3J0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEdh
byA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogWHUgWWlsdW4gPHlpbHVuLnh1
QGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnkubGlu
ZGdyZW5AbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS2lyeWwgU2h1dHNlbWF1IChN
ZXRhKSA8a2FzQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiDCoGFyY2gveDg2L2luY2x1ZGUvYXNtL3Rk
eC5oIHwgNCArKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJl
QGludGVsLmNvbT4NCg==
