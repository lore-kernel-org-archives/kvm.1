Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC028CF4A
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469576; cv=fail; b=PBgqxyohylYXkaDSMWgpoaJx1Owe3o+zvbwSbE3FW1KXp97GZ4BfMSL2leke+fn5O0eiEU1GbP5lxTrsoqRLMTn6z6q+2lQhwcVnThRwOTi5ern9Y7cS6A80/ZE80rnlWtzUyTYCH3B8pGaVAcl3oSICE/ZuNs16NluAsoosf1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469576; c=relaxed/simple;
	bh=k8UHvFYjLY1pjY6h3Zq7ItxJToVXL61mp9C7klUkDh8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FhZoX0Ip7QR0KFYGtY31V1tAQqZ5wSwIaR+q0tF64vxI1/sYgt/J6HLHxVZyoe6pwT73u+4mqnh+2pJKr7652eITRJ3QVh+o3r3fMRnMdN+9RpH95/NkYLq7M2UolTD+VMVGzeXBQEtMdJ/Vn9J8TOQ4st0fRkYN7nIqHjdUviY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUm7HrsE; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUm7HrsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786469573; x=1818005573;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=k8UHvFYjLY1pjY6h3Zq7ItxJToVXL61mp9C7klUkDh8=;
  b=gUm7HrsEpFs5hBrch23BoakNCmRfLx08m4HSz6bCx7iRwjWutwncxAH+
   4gsnBIID72fSrAy7mwtRDmDdYH/tjasg4dutsHoSNedPDe05HOVZULMoU
   T/W3mBO6pr1NY3IkrCRikYaGzENKd5Z8U/t9rwNwd7ezGlQ3EHgk9wf+P
   ZRFxwLzNoa4Zq7vAZ+3t7nEMgeYiOgysNooXyUEpB9HasDAb4zQPc843o
   zpRcBq9uMGeMqqsprHV3Xrm4XsNJrofccuDBOq39u82jclPo8938jLcEY
   LhIx+vmo6kZCynz0yGCvt98DiNHLFxkKpyKyIwv6+2k4FmDJvXICJodjF
   w==;
X-CSE-ConnectionGUID: M1dgUX1nQpGh3nJzND9CVw==
X-CSE-MsgGUID: uNltl7RKTJyuxKGyWgh3Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98155459"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="98155459"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:32:51 -0700
X-CSE-ConnectionGUID: WaUXgKs2TteJnfO+VSfyJQ==
X-CSE-MsgGUID: sQf7p4c4TC6iKCQBqAGN3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="267256131"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:32:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 10:32:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 10:32:51 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 10:32:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3DtKtgTIgcVjjVB6741toMs0gJ7LgV5sTiEkJWh+ClPJ4ps//pw3CFClY8pwTOjadjoo0jrayM7ZQoKwBAW4obfYJCGnHIQDsUGttjtu+xxesIE7J7P/EWtOYYmTyaI7OHVSSdgcE8u21kFnJzC9fRJi3PlshhkMBWAPL8MEuwzZaVAHaWRM/eGJ7qXszXLr4cdaNHjmiR3NwIJaZZ4fMnC6sBupYy548KmSZvHbelvSikcYtDKaytOLgaCBF7cbARsyNjULH0lCqsr7PW3di9tWOgwri2+vBD4oRJNiMvSPuYbykPBF18DLnAI+Z+L1gsdzs2EA7v3q+yPcrLbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8UHvFYjLY1pjY6h3Zq7ItxJToVXL61mp9C7klUkDh8=;
 b=XENGFqOKi4TpzWgW05ODZ1Wl2W21fKs/ebJ+PIXCtfYr19K70ljr2++apW1bGCmo1fmRP8xkQSA33jB5Yl1uYVDg1UEazAnZTJ9AcCvxkJB8Xne+PJUyTiDiMpbIonsv2RxJ/i3FSTjuNzyV1mw52SoUPR7F1tq7P57vlYOStcnUdwR6q83IJ96dK9NBubj7tm45oaIvD6Yj7zpjrA5rw1zJdV5r6yfp1qfxtsEr9p+TO4WUlKdtxKE2hkRwwWVPkTnPTF4Hv+I54nC3rsQSewdGrOM9ZviLvrVKqdb+cCkR/9CEtiINxKQ5sk/oL9RHheqjHmQviRPvDB+ot11PGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH0PR11MB9749.namprd11.prod.outlook.com (2603:10b6:510:397::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 17:32:49 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 17:32:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"pankaj.gupta@amd.com" <pankaj.gupta@amd.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
	"Lindgren, Tony" <tony.lindgren@intel.com>
Subject: PUCK coco migration topic
Thread-Topic: PUCK coco migration topic
Thread-Index: AQHdKbdtutv9jBZi1U675oxbDY05OQ==
Date: Tue, 11 Aug 2026 17:32:48 +0000
Message-ID: <78aa2a375ce92ac37f084dc44ff8ee126b7ffd22.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH0PR11MB9749:EE_
x-ms-office365-filtering-correlation-id: 97d972e4-450a-4854-139f-08def7ce9034
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|11063799006|56012099006|10067099003|18002099003;
x-microsoft-antispam-message-info: /rkowSEv3v9qOQ4ALQhXZw7YP+/+tRqginUa4JW/z5/AZXtkhQU/7Byx+tIQFzTKANl5wKVI19OUJooR+C3a5EB0rMoc/upA8wuoanNvS1qK6tahUfq6LGGhMOEaCxymIq+EpElKyBLv7Gblmp/9kca7KKsGIGBY30wqpktE/6eO4eJ8ZSas4H/UOwDX5HJlw/m70N5xTZ3/IVGRV8s+PpCHv1CgoiLrmwk06vEyh7zcfCe1sZSJr1Vk08JJgk41CqJcvKvInbC2Sa+cYJtamieam+B4j1Dt34eRwnd9TBRS4OWPfT6oHnRpHRLh49bEzuLUTdcz8VLf2KEIITPLbMxFCAALKQLol3+Z63tJlXYAyoh/7A94rfPJpldOBjQm9ancZlZYp8kXjq6NmlROT3LlziEVcpzi7/8JxtU6lBDhEdkTL63v+V8EaF1o/PxTlySawXy2jFk1twfSmRIGJJqV9M/5TJ2uCR1O2rUxWdjr9GT9EZO/FSKgcs/nJYxyFNnoiU7XPLjbn8qVptQt3i/OMVKT7Peu4z9OmfjTYdvK0YbIAT0SUib2pEhvZfAdFOmfxwDMICU5FWQmY3r+eMfNxS6X//U4nA3nI26L5Lwy3jNcfaCtiadZpbRBBWbNl/AaN1ZaH1WSu1Qcj6ynIayU24rQhMJGlGEF2W/bEQt5w3Ajk8w2pzRTt8UpNf3HIBWNSZQAHmjT8hiReQO5jp5Hg5MFpVYoXaALi0OkH18=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2loZWNWWnRESHlqZXRSa3h6bmJPMlA0RmtuMzhxdjRueHowMkdLQ1l4QURX?=
 =?utf-8?B?cElmVmFKM1FKQU5UWkRMRktNeUx1ZkY4VlN0NisyZDVDZEh0aW9FRVJCVnJW?=
 =?utf-8?B?bXA1R0QzaHovS0wvU29sUTFhMFUvWWprUmp3TW5xcU9xbVhkSkJRNkFqVE9h?=
 =?utf-8?B?TUZVY2tuUVIvSDFWTlBjNFZsNGJEaWJpWjVlMmJHV252ODFaOGVhKzY0S0Fh?=
 =?utf-8?B?YS9BMjMwMmljeFI5MDIzM2lndG01cmpOdTNTTnJkdWRQMnltcm9zemYraTFV?=
 =?utf-8?B?MmZtNVczWWVaRHpoUW9oWGtLYVpOdXUyb2lTZXdlWjE3SllqRkMxdmttOVZt?=
 =?utf-8?B?ZDBwS3Y0b2ZkdHVpNUJWYU1nemF3b3dkZ1YzZ3NOTlFkR1g0dWs5a0ovN0Rz?=
 =?utf-8?B?eTdzeEthSzVTN2lqQkM4WnlBeHJDbUJxVmQvUjVVUGtkVGxpQkFRQ0ZyajVZ?=
 =?utf-8?B?ZHNnalRSN3R5WXpDZVZGcCs1Q0lVcnQ1M3ZLQitvcXhSRTRyMTY0MW11S2NJ?=
 =?utf-8?B?VmRYbldLR1VDRUIyMG5DUElmc3hqcWN2OVRYL1Z1d203Rktod0dOaHpkRXdN?=
 =?utf-8?B?L21vUFI3L1pieU03WnEzS3JtYWZ0cWtSQUhvS3lyYllsbjVkeGpaMU1GMUow?=
 =?utf-8?B?cVEyVnhpbUc2cHNzRTAycGk1S2ZNN2c5VmpCT0hVb3BrQUZ4aHJjQmtCemh0?=
 =?utf-8?B?cTcyOVJ3OWx1Nk9Fc2xhOTlKdEZJMFhJWDB1ZVNJa2FVMCt0VXFtOXNrdENp?=
 =?utf-8?B?YzFaUkZwT1k3citFL3F5SG96d1BiNkdyVTRXczFXOVFBNXQ1ZlNqeTExdXlH?=
 =?utf-8?B?SzR1TUhsWmZZOW4xRFNKNFBENGRkUmRkd3VDd2ViZlhZQ2UzWHYzWWlSdi9Y?=
 =?utf-8?B?UHNrOHdjU21CZVZMN0lVYWhBQjhROVV1RmV1WFo2L0pJNDFTRHl4RTRINmRT?=
 =?utf-8?B?VlhnRnZkU0pwMkxVNHhJSjd6TW0wKy9lcHMzbXFQNE8rbFVVc0FzV2pBOXhp?=
 =?utf-8?B?Njh2UHZSc3ZYN1MwNmdYaERsdU9nMWN1d1dFOVoyK3R3eDUyUkkyL2xLTUwz?=
 =?utf-8?B?VGJ4NHZvalUrWlFVVTRhRk9UNHlwa1huNW1MUjltZEVvSXZGTUhBdkhQVWFj?=
 =?utf-8?B?TmhTRWtmbDJLdGg3Q0k1VDdpeVFJSWtlcVR2SE1tYXUzQVBzNEhJYk43MEl1?=
 =?utf-8?B?dmJuNTJydGR2WkFPclNId1hOUk5PdW5rWW50VDNPME1VSTBlMXpnMFc5Qk9x?=
 =?utf-8?B?blZJWXpOaVlMU2p1MHJLY251bzYrcnBqVHdkT1Y4andQZytZMDZSTjREUUxE?=
 =?utf-8?B?VUNodGNFV0UzVHhtSUtOUEhWVXd0Unc1YXFRb3hGanJDWE5TSHZTVWZ1bVho?=
 =?utf-8?B?NUlZSE9wcXBkU25kUktSMzJaN0toMTdsVmM3cm9hakhhY3dncWcvR1g4VVN4?=
 =?utf-8?B?MnFlSzREeTVtOEk4eXp1TG5oSDRMa3VnYjVYQTVPVk9EeEpRb01qcGI3WlVx?=
 =?utf-8?B?UUtEaXZrTzNrVUlicGRFQmNmT29PZ1k3d2ZOSmFVR0xXSDhvODc5RDNjOHF2?=
 =?utf-8?B?WUVZcGwrWTR6UnBTWklLOEdYdi9VV2lOdmFYU1IvTTJnVU9yV0JTdlNkdzY5?=
 =?utf-8?B?SElzMlVud3JpU2lpSmQwTnhxSzdwQTc4b3Z6aU94dFY5SHhXZjRUbEZuQy9P?=
 =?utf-8?B?SmNBd0Q0Ykx6YmZ2R1lsV0pEVThtYUZibmJNRU9xTUI3Y2F2MDFXMHEvYkMr?=
 =?utf-8?B?NzJKVStkRUZWVWpMQWFsNzFJenF6QlVYV0hBYUgzZGM4NkFoUnNPRkM4bDVq?=
 =?utf-8?B?dEcrSWxzOU5hOEhIYkVhVkg5ZEFpa0FGRldvTEZ0K2dZNUIvNm5zdDRwUWFq?=
 =?utf-8?B?UlAxckE4SnU0YzArdWEzN3liajFtVDNnc0JIK0kzaEhydEt1VDZYWG1MZXds?=
 =?utf-8?B?eElNMjZ2RGs2S044aFVsdlN5MVFqWk1YbzRvMW5wQUJnWFBKenM4WXhNTHVo?=
 =?utf-8?B?VkF0UFJGajBMMWJIREJRbllpcFBSZkllU0Z5L0ZGMUFOMWt0OU5QeVUzS1BL?=
 =?utf-8?B?MHlhRmtDSDhrb0ZMd3BuTjM3RUc5Wk9yb3VNSkpUQk1JWGhKbWQwdXdWSFpQ?=
 =?utf-8?B?aDRLbzlaSjdDS1JrdlhJYlZtWURIdzFpOE1lZkt4TDV5eHBacHlRUXArUUQv?=
 =?utf-8?B?aXptb2RkZEwxdUVJRG1oY0tFRWE0eWtDTi93WDlOWitEVDFTK2FQV2Q2V2JQ?=
 =?utf-8?B?TSt4ZTZlc21ZRkt5WFZhWEFIUGNPTEhOeHFIUUpPc0locDZlMUpWOC9sZldK?=
 =?utf-8?B?MzNzRkZUK3Jid2U3Qk9nRzczLzYrczBta1lYSVd0b3NZMm96YUhYbG9lVE5B?=
 =?utf-8?Q?N2jnSZ5JWJV6+vzk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D51E4ED628E2E44B8F757C4DF7205AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kfHmayAYtGvzXTfDkWWcw5mkFjNFZWyE14XOEDIN9E30D17J3GZKXRD5GDkJ5EWFppkV995+K3yClJtDi/kMbk+m2utHFnazCZCZYaWpkpVvVZOXooP89nkU5pbim81iRscKvBRma+XcBAAScZYm9MzbvOHOC3BegDWny5LFJZrFOggg6Kc25QhKFA6Kc4kDCazTffIZo1fsODQky60HDnnEmUY3wfNZqjOQYB+EzE/Ft5O1npJ4RrxUajHo76jRDOaqp0SHu0E9gDLpLvcQfs8zVKnd1o4PRUhihGE8djPHK45psNXnURmfzPzk5OVaooQDdGw2z2x7qzvKNSU9kQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d972e4-450a-4854-139f-08def7ce9034
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 17:32:48.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quyKJa8nrT4rt7JwoR4a7n6c5nTgG2mOHuDOE5PTuBgy1nR9Srx/1U3xca6/qCEMAxQIukz9LEIIMoONoHD2qcxSvS5SD1myvvDPzT645pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9749
X-OriginatorOrg: intel.com

Q2FuIHdlIHN0ZWFsIDE1LTIwIG1pbnV0ZXMgYXQgUFVDSyB0b21vcnJvdyBmb3IgYSBsaXR0bGUg
c3luYyBvbiBURFggbWlncmF0aW9uPw0KV2Ugd2FudCB0byBzaGFyZSBhIGhpZ2ggbGV2ZWwgb2Yg
d2hhdCB3ZSBhcmUgd29ya2luZyBvbiBmb3IgdGhlIHNha2Ugb2YgbGVzcw0Kc3VycHJpc2UgbGF0
ZXIsIGFuZCBhbHNvIHRvIHN5bmMgd2l0aCB0aGUgU05QIHdvcmsuDQoNClJpY2sNCg==
