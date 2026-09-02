Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DC3B9DAB;
	Wed,  2 Sep 2026 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365401; cv=fail; b=DQwo9G0WFyb7d0J67mVwvkZln7qT/HIXFyVzBcfEjM0eXIPU6fFCIGJZ5eR8ab9F67itYvR5DDnAqLpHP7fIV5vqKj+ebLw2fHeMj7sfVzZutZHQMMbarCcRD7DPDpQm9hfmoEGMEGKr0Hl/gyJyIYEofC1VR7soUM3qunYb9/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365401; c=relaxed/simple;
	bh=s+QoDRkDKWZyfq+s+G93aqXfLmrR1+GcyYd+DBzGtJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdGtUZA3pQo1btxbwLjqcpLgAxsHjVpG56ULj2/kvOALAoqoftW8L2imowb1GG3/hftUnQL7Qr54KE4N8Mrpoh5jSipWSuCyxvkxOPKYcT83Mp5DyOMfwDNP8DHTnJ4DwaEFB50s2QXBAxmw1vwhpov4X44Aurq8N8z+fSo385g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSrecYVC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSrecYVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788365398; x=1819901398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s+QoDRkDKWZyfq+s+G93aqXfLmrR1+GcyYd+DBzGtJU=;
  b=OSrecYVCFzl+EZf1lKeHkJ/Jr+zTGLQB+IpUoZZfdby9LDYsjqO0c/to
   mJol6hR8q5zZfGoly6w3yT1PI1XJZLDLIilMp/eRHGoQoKSLgWqZbIl3k
   ZcVmk+jxIyZ1+0SBCC6IPIANw5gSkprECd3/9/e/dE1aQaCYURfjVd0t0
   vwL+49AA5iJAh2zRFRhxxVJMn5pAFiEOZAckTunFnzfz14NAk8zfSTPKF
   AXa1gOb1fL6Wmdn2Z7Lbe7K3ku6gz/PDciNVm3JEgCYAQsF5VgWOHt64s
   n987sSI7IvIsi5F7xXYp9ESlPh4uMzYTX/F4Fa6t5pjXJoy5pZPFjwAeY
   g==;
X-CSE-ConnectionGUID: etv4AAb8S2Wp473C7DHaFA==
X-CSE-MsgGUID: 2o37Nw1OT8WykzKZo2ZRLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="89039279"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="89039279"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:09:57 -0700
X-CSE-ConnectionGUID: E/1s6tw3Rc6Tr3bRlbjMKQ==
X-CSE-MsgGUID: aOL9OtAYTYqW1JuYD0bgVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="299321432"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 09:09:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:09:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 09:09:56 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 09:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqs+qoHDO7VAkV9y6GY/qi+/7bVe8XUlGHYV59WDZwRfm17aq8xx+nqKzNGySxbWM3y1a/icDsQd2zr6JJY3KvNzVnVZKKKaxvCLv2+O3cg9RTrOLXJYOXY3gQcE06eDIv1fNO3mV8dVIQSSbuESIWX33twLgihV8wWFMtTp23jXBVYqeo424vmqjWIkPV/hioNtPHA7Uq0tGJpjfjh1pKULCamRarCJ3nuMmUHYizKpmOOkfWZh4nkFfUm9hXJeS1Hk3b6e7znFN8KikhQo7VSKG+JNHVzJTzpCxvcYL5Ht/UTItcUvCSiMmsiTYcxCl+w7norLASJCv2k3lpz7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+QoDRkDKWZyfq+s+G93aqXfLmrR1+GcyYd+DBzGtJU=;
 b=enC9Ui94i+mmjw+6oBdtV8k7kRiVEwrRkLuWc5hJvu+bVJhTE/EMhcvPJ2TlgAJaZJY5Ad9eSs5OhqtYx5orGo/C82epLTto0Tp3NM76WZdOj7pa5g4o+U0uSdo2PUHNQaIuSnJ2Bap3HO/JdI8KRCMrHo2vAENJh6F6CctstbmLxj8LOn+BGcboPrEcBoeE17deWPbroR/o1kIJQYataT+iK3GSedE5AQYaasrouwbugEMEtK54bg7LTmTpVSVhZbrwu7PiOlNDtdpX4I+bpDiz+o9+ULZgJfz9XNlyrcSgIsUVlSG4oM6HVZ5YBOmts0T5Sjp/TxnxMaEpHPT4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7287.namprd11.prod.outlook.com (2603:10b6:8:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 16:09:50 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:09:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Topic: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Index: AQHdNdIhqH6lArRWVEmiaZbi1C7mgLaySiAAgACCPACAAOTNgIAD7r8AgAHg6QCAAf53AA==
Date: Wed, 2 Sep 2026 16:09:43 +0000
Message-ID: <328ee2d79d462f516a14b7460ca468752620347e.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
	 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
	 <1deddc78d14326b378ddd62ad99c21d66da401e6.camel@intel.com>
	 <f7a3b14b-d31c-4a46-99e0-055761d631a9@linux.intel.com>
	 <2f27443d-935e-4486-babf-51d93c391369@intel.com>
In-Reply-To: <2f27443d-935e-4486-babf-51d93c391369@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7287:EE_
x-ms-office365-filtering-correlation-id: bf65dd85-e649-4e00-9e67-08df090c99ff
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: edS37yrQrkAuCvHN/cSDnaI9LzcZ7Rr3xA3flBIi0c3rjH6xtGkwlidtbiD02ORwlf7q+oylFQtlEiIoFHELdVWeWvV0Jc4k2BKINS+vbWwnf3eF+XICGKwGwoBzyhl8/4XMVl0P/C3bnca42QP9VVLZtX8/EYCGyK42Ckp/TNzeFtvR0EoK0Za0rVnXLWnlu7mhRErM8OjP0pC00zl+DVCS+bC9PF4bwNzR6vCzCE9z8Ctt4tNoVDgXeNhUXMej4Wp4vO0Yu1A+1ng4465JcbNcUQpK0/zUZcZSQnGnrpiUc11+0dIFWGhQQppWzaVBjfyKbDxV/2V/USbztgSTtN//YGhHn+HdwTfO0XFtMCuoXHRqk0lk6bJ+cCG8SIMzCVxLMeUPaFxhRWc2rrdguo4V2w1ptUA8GzACvGvCxYwo8PerCzL6ozVgowLeHHFFI/1KjBzPpAH7/qBa7ub1HdtP2eNF84QCyL5pZRuXu6RpS7UnkMDMtpQMxgtIcaPQaEyFQHdK9MX7SECR6BlJ5rfX1vH+HLEydkZf5HjAp1eps3R5719C64a19YkxyL+w20xcfbIdjpbilt6UY1phH/u+qQFgWp2sJ05R0fSxBX9/DayVbuUG+VBh4BwcyoZf6ZEs7cYLdx8qQP8+poIfsmNJyUoJIKHBT0Qhliwi2W86dSqkcerkgQpyxUFBxwnF88QmrUzxYv79TkROqGrT28KgGeoxBu2WUVK1t8h04GE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bThHSjJ3cVZnS21uN3BKWEdxd0N5ajlLcDBPZDhFdFJJOS92TExNbDNMQWI3?=
 =?utf-8?B?NGxKbFk2QXczTU40a2NsRVh3dTNHdElSMHBrTXJORlVFektzU2NHZXlIcG1y?=
 =?utf-8?B?Z0Vmazd1NVFPY2JKUU5zNmlma3hUKzhTOTYxS1liVE9kREpHK25CSjlMZFJD?=
 =?utf-8?B?dTZSd0M5Zko4MFdCMmg2ejc3NVpJdi9Pdm94czc1b0JQNjhUd1UwcHJFc0VZ?=
 =?utf-8?B?RlNEdHkwTDlLak9JaWtyYzRPQkZLblFHN2xyWDMwdUJMdzVOSUtTWGYxNnky?=
 =?utf-8?B?UE93TXI5NjZsNHdRaGNnR2tvTnpvaEU2NnVCUExzK1ltOCszbXFVWGw4Znpt?=
 =?utf-8?B?czZiVHJsdXEybkxCT1dmU2ZncWJzRVlZVGxmeXRuaFZiOWc1WFl5N2lFbnBI?=
 =?utf-8?B?ekZlR1dCS2gzOWdwVnpnaTFGa0drbEVHQzhFdTIxVFNQRC9ORW1Qc0JTWUNS?=
 =?utf-8?B?amV4VFJhU0JtU1BRZTdObjJwaTNvcHh6eWROVUN5SmF2aXkyRk4wL2RnR2Z2?=
 =?utf-8?B?bXZPYm5SMm1qQ3BCNENNaEJjQ2I5REVYMythUXY4cUpNMVRabVpLdE1kT2FB?=
 =?utf-8?B?SXFyOHBOeTRBcE5lU0JQbEhhVDFBZDFGdGxRSGI3eGljenYzcENlZ0R2V0hR?=
 =?utf-8?B?ZmVmeWk1em1MSk9QSm9pblhYczd5K3k3ckswbHp1REkyUmhjSkpQNWhDWWpU?=
 =?utf-8?B?ZWtGNXc4YnNmM1lkWThQQXNyUW0ydkVPazNwRXFUMTdLVjdUZVN6THY4Z1dW?=
 =?utf-8?B?eVZtNjhkMXN3UXdiVVczN2ordUxRSnExZERMbFJCZkxOWTlodzlEVXRjUXMv?=
 =?utf-8?B?aWoyYzlKMWhIWS9jenVWaCtqTUdWblRucWpGdHIyc2dnS1NhaWdtenlQYUpp?=
 =?utf-8?B?eTNaMEVvWGsvYUVmM1ladTI5Mmo1VU9CWnByK3FJeHlhcFMrK1ptcUhEbytz?=
 =?utf-8?B?WFhEVkpQSTJ4bFNHQlIyMmVmMXhlRUtLOGhabTI0dmJoUlQ1T2ZhZzFHWnQ2?=
 =?utf-8?B?eEpqcGVZNmFVNnBhU25Zc2RvSWFMN3N1NXJHRmwrdDR2Z2tWS2tKaGMza29O?=
 =?utf-8?B?UE4xZEFqQmdHZDJpQm50WVpzY1R1dE9PNVpCV1dtbTRBU0VjVlBueXg5NUJk?=
 =?utf-8?B?aDFOY1pzOVE3T0NISG1JZ21OdCtnOEFVc2x3ckVYNkM2dGdseFRhbGgyQnBW?=
 =?utf-8?B?WEd2TDZrSG9jcEtNMkN0VjFUMkNUN0t2YnJySE1ZK01Tano3Q052YnNEZ1Z3?=
 =?utf-8?B?SlQ4QnAwZjlLdVlrNVNNNjRQRHpVV0lUN1BSd0FVblVaUGtBNlJxMTNVNW95?=
 =?utf-8?B?a1pJSy9MV0FtMjlnTDJNVGt5alZvMlZQTmVYNStuam83SzM4Q2MrRGhHUUs4?=
 =?utf-8?B?NHNXUUN4ZmttWEM0VFBySHBrWHM2UWNHZWVGQzNMMTdwMEllT1I0Zi9JcUl1?=
 =?utf-8?B?OEtjMmNBcFF2c285TC9OUTFmdkRUWWdxa3lKYnkvT2dtYzVDeEVYMUl6eVcv?=
 =?utf-8?B?ZjFzU2s1K2gzcjVmc0dveDkrL1M4MU1EY1FhaXdIZXNyUS9PVjNZQ3g2djhT?=
 =?utf-8?B?NlB4UENwTDAray9ITkxHMXdGZXk5WWU5dXpLeVd5RE40a3k5WTEydG5FMUlz?=
 =?utf-8?B?a215REdqcFFkYlQvLys3OHJCMnU0Zm9LdmZVVCtRbUJrZFRJNlkyL1MyZEM0?=
 =?utf-8?B?VlNKc0pvSlNxc1lQZWxjalZUd0RtbzZQNzBSNVJIdkRDSGNGQ3pZVmxFL1cv?=
 =?utf-8?B?U1djbDJiZnhUWU5McVpBK1VMaHo3Z1BzU1RyVWpvOElZcHFYV1RUVHJ2K0M5?=
 =?utf-8?B?RE1obis3czdHaGl4NFgzSnlNcnI5NzZrV0tRNGJvV1F6V1FOSENaS1U5UHA4?=
 =?utf-8?B?K1o5MDBDRjFSTWQvNE8xNU9aUzlmVkJvdWRZVUYyZEpsSVlEbEZSRzVKVzRZ?=
 =?utf-8?B?QnlOWmdua0JpMFdBbnJKUExadjBSQ04xaENRMFhwUTk2RkxmcElXSENhZkgw?=
 =?utf-8?B?T0FHRWJkWkxCdk1EUTFMR0tBZVhqd2cyajQrWUM1V25KNnc2RUVsZmp2M29I?=
 =?utf-8?B?aHdqenhrM3FlblZCNDYxdFRNZWZJTFRDWFJqbVlKQUNZRkM4aHdWbFp2UXJU?=
 =?utf-8?B?a21VUWMvS2VNWGVlRnRRbWpScTN6NEcwVzRlcm9VYmNtQlhMNVBnOGRFS1NE?=
 =?utf-8?B?d3lyUUNncDJBQnViSmpoKzJ4NjdCdmIwZWxYQmlzSHNmTSt5MWlraTI0djBv?=
 =?utf-8?B?TEtuVWpSWXZyaHE2ejdQWEpjN0JLb0VFZnZROFY0QUlvWjcvaUFwMjRCZGsw?=
 =?utf-8?B?ZjVrYXI0dXZXSkpScDQ4Rng1Nkl2MDhpS2NvRlFMcUlMWHVyUytEUSt2WFNt?=
 =?utf-8?Q?a+uYQ3D4mzmMSVzw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7368E28BD7B8B429BA29C820933C389@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WXpKdQWVHSL6I2WMER4UoS8DqMLDz3s4mIfjtFd30SlgWqDdx/nMNdtgCKduTYbomlg68qhURKaG3JiexCs+ZAwcCG/COUgFlx12RKSP1tvkHApIEZn35SR+eH8DYT1nZPqKp2abZzXfucAXJEkQZHdblizMfbXyhmzZuTZwJezkSYJP7Yhpp63gvwYZdIaERNNye1+8mS8n5YTRKQmT2vQn16SpzNNfnqDMBW1NgK+707E/7glrG8/EB707c6pXA/v1vhIErnPQzJB4DvvT43PgVbDZ++asdeuyJzSLF4Ad5ZtRzHvj8MBbzO32VjSNBkgVhoWZgYPH0YDSVR8nog==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf65dd85-e649-4e00-9e67-08df090c99ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 16:09:43.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HcfeVjAUwttcGbjMS6Tw5JuKTa4mapbgx2QPr8IPoCglCm8bK/V6qox14d9cRf9I9rVmfIlb8B/udamo4apFAbctEHJ4GwT9bBfudrkYTOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7287
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA5LTAxIGF0IDE3OjQyICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBP
biA4LzMxLzIwMjYgMTowMSBQTSwgQmluYmluIFd1IHdyb3RlOg0KPiA+ID4gPiBTbyBpZiB0aGUg
YXBwcm9hY2ggaW4gdGhpcyBzZXJpZXMgaXMgdGFrZW4sIEkgdGhpbmsgd2Ugc3RpbGwgbmVlZCBz
dWNoDQo+ID4gPiA+IGFuIG9wdC0gaW4gaW50ZXJmYWNlIHRvIHRlbGwgdGhlIFREWCBtb2R1bGUg
dGhhdCB0aGUgVk1NIGlzIG5vdw0KPiA+ID4gPiBmaWx0ZXJpbmcgdGhlIENQVUlEIGJpdHMgc28g
dGhhdCB0aGUgVERYIG1vZHVsZSBrbm93cyB0aGF0IGl0J3Mgc2FmZSB0bw0KPiA+ID4gPiByZXBv
cnQgbmV3IGhvc3Qgc3RhdGUgY2xvYmJlcmluZyBmZWF0dXJlcy4NCj4gPiA+IFllcC4gQ2FuIHdl
IHRoaW5rIGFib3V0IHdoYXQgaXQgd291bGQgbG9vayBsaWtlPyBFYXNpZXN0IHdvdWxkIGJlIGEg
Yml0DQo+ID4gPiBwYXNzZWQgaW4gVERIX1NZU19DT05GSUcuIEJ1dCB0aGVuIGFyY2gveDg2IGlz
IHNheWluZyBob3cgS1ZNIHdpbGwgYmVoYXZlLg0KPiA+ID4gT2sgdG8gbWUsIGZvciB0aGUgc2lt
cGxpY2l0eS4gQ291bGQgY29tZSB3aXRoIGEgbmljZSBjb21tZW50Lg0KPiANCj4gQ2FuIHlvdSBq
dXN0IHRyZWF0IGN1cnJlbnQgS1ZNIGJlaGF2aW9yIG9mIGFsbG93aW5nIHVzZXJzcGFjZSB0byBl
bmFibGUgDQo+IGFueSBjb25maWd1cmFibGUgYml0cyBhcyB0aGUgYnVnIG9mIEtWTSBhbmQgYmFj
a3BvcnQgdGhpcyBzZXJpZXMgYXMgDQo+IEJpbmJpbiBzdWdnZXN0ZWQgYmVsb3c/IEluc3RlYWQg
b2YgaW50cm9kdWNpbmcgbW9yZSBvcHQtaW4ga25vYnMuDQoNCk9rLCBzbyBpZiB3ZSBhcmUgYWdy
ZWVkIG9uIHRoZSBvdGhlciBicmFuY2ggb2YgdGhlIHRocmVhZCwgdGhlIG9ubHkgYmlnIHF1ZXN0
aW9uDQppczogRG8gd2Ugd2FudCBhbiBvcHQtaW4gZm9yIGZ1dHVyZSBjbG9iYmVyaW5nIENQVUlE
IGJpdHMuDQoNCkkgdGhpbmsgZWl0aGVyIGlzIG9rLiBJIGRvbid0IGxvdmUgdGhlIHByZWNlZGVu
dCB0aGF0IHdlIGFzc2VydGVkIHRoYXQgbm8gbmV3DQpjbG9iYmVyIGJpdHMgY291bGQgYmUgYWRk
ZWQgd2l0aG91dCBvcHQtaW4sIGFuZCB0aGVuIHdlIHdvdWxkIGJhY2twb3J0IGNoYW5nZXMNCnRv
IGFsbG93IHRoaXMgYW55d2F5LiBCdXQgb24gcHVyZSBjb2RlLCB0aGUgYmFja3BvcnQgd291bGQg
YmUgc2ltcGxlciBpbiB0aGUNCmxvbmcgdGVybS4gSWYgeW91IGd1eXMgYXJlIHN0cm9uZ2x5IGlu
IGZhdm9yLCBJIGNhbiBhZ3JlZS4NCg0KQXJlIHdlIHN1cmUgbm8gb3RoZXIgVk1NIG5lZWRzIGFu
IG9wdC1pbiwgYmVmb3JlIGZpbmFsaXppbmcgaXQgdGhvdWdoPyBCaW5iaW4sDQpjYW4gZmxhZyB0
aGlzIHRvIHRoZSBURFggbW9kdWxlIHRlYW0/DQo=
