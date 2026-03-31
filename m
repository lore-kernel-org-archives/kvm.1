Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A127B353;
	Tue, 31 Mar 2026 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981334; cv=fail; b=Ho+lgExd1I/cCTUaiFEtKaHpBvIRIJ4p8nlvgME/E/hh8DdlqG4Ny68j6UctfZs9m96VYHrJJ9PHasof+dvKn1UoLsaoi0hLz5GTOWUtw30xypRBFygn1Kk2HUJuf7grZE2a6p7/0MFXQmLZowncptljWb/T26LjA0N+0h5CCZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981334; c=relaxed/simple;
	bh=h4K78In9omwGOBh0q0hmzfGRKg5e8dtjd0lti4a59vc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nubCUa9IdOmVpqu2+dOsFdXLGiX0TjV3RCTtSApU26S1Kg35dZ19RZE0Tr8e6a9YUR6Amoq7dzsf2AxpCWKbflnC5hB8293KTXVd6QCeTvnYO3IKGL/DYKP7Be2MyTbNvMjPqlKL5JwejrEydbFqkxqB6j1vQCYM+xhwK8+We+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glNcdDJT; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glNcdDJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774981334; x=1806517334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h4K78In9omwGOBh0q0hmzfGRKg5e8dtjd0lti4a59vc=;
  b=glNcdDJTq6bPla8K+Adr2MuLCUO+4B1Wik4n+1f7hh6pBzMOoq9nVfw6
   gjt24mZuTOnsZfJPmuSmpJPfhXLs3K31aBuQc+gCiwIO0pEy0Ty8dDmGl
   z5+7/5G9xOXnhRIThselhTkSa6WgJd1b1Xf1voWLDtx0NyW2fxqQntb3F
   qiHJ0Z2+n3QII5DTDtj3c+d3Oa8npMcMipqm6n+mQY61soHu5Mr1dJ9XY
   EUZyxEpBx356wbt8kdGLbbBhKOJsLH/8jYeFzbqLvJUC9i6w1ccmQ3LiN
   9J+lTp07XxFqEYAlCpZNYZlSQ93ln01N9g2+divvwy0Df9LzlX7LQp2Sb
   w==;
X-CSE-ConnectionGUID: x1YxwfgWTammfCOZ0zrZnA==
X-CSE-MsgGUID: opNfxlTlRMWF+S3i9x1tXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="93587893"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="93587893"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 11:22:13 -0700
X-CSE-ConnectionGUID: Fo2hrbJYRjGdiZ5tsN6Cag==
X-CSE-MsgGUID: mu3GKKNqTTGRjRK0gHZ0hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="223562299"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 11:22:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 11:22:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 11:22:12 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 11:22:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyANnsSS6AeM5abaMZl0IEvyhqATE6+y2AqFkzvXMQeiDm1+PwIjKA6bmSHuIoaKNjW3aTTJjfCpAOB03sqQwTKyV7YM8zT7Sk4zX3zK2zEN0Ky2rhWqp7oFduZu9QcOnyHHH8jA2J+FyLgS+e8aj3JdAaC5S7jUqHbAIPv5zbGrNjUc7eVkyZTU/qRQNTb7FijSBKPNWOWfu8ul+SonAnMzOJT35EzI4KA+7YAbH/yxWe0KlbdEZKpgE+FY0KEMnQ1H7VR+FXyf1TyPVlMRFuYEgqLrlzn9HzNk+O2ejpvE7lf4221DiUqbLGoQsFaQVW2Edq0PHB8DXLcFRGID7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4K78In9omwGOBh0q0hmzfGRKg5e8dtjd0lti4a59vc=;
 b=iV+lHHkbVJlhK/44HhB+nWttR5UsCdlycx9bjBTd0MdQvyrwb4tUhHCqPWVRFbrruUAFulRIT72bYGQJcfOGVtB9O22HrNRmDiW0hqSaw6ZSmVcTG7+BOxsV9n0LVH2STmNwLA+60U/f0Lmtd8AWp909pBf3BgfHWoDI/tlO6g4JQc7FHwL9UIQera1ZwZuAjzxVsTYi7RqlO+tq80eQTjpQ3avTvLSseDMbP++XO+SbbZMiYoV6NUgBZuRWNoaLLFRZOz86nPaKMLZ6To12rysk0uesmHWPXK8xERtxR6iQi40YCp80MkM4UVgmqzxVt+6wmTkyM4TgS35LIZ4z7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 18:22:02 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 18:22:02 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Topic: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Index: AQHcuwf01Errp9mqPUyCn3sEkXWS27XHAxsAgAB8vACAARsNgIAAZZWA
Date: Tue, 31 Mar 2026 18:22:02 +0000
Message-ID: <b9aa84d76c131132b5268712a44200e804c31aeb.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
	 <acpiGUKS-WRmLoxp@thinkstation>
	 <def1f4395865ad0d22be245647fbb75ab8698ab8.camel@intel.com>
	 <acu4raBTjdFcfVlS@thinkstation>
In-Reply-To: <acu4raBTjdFcfVlS@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|BY1PR11MB7983:EE_
x-ms-office365-filtering-correlation-id: ea447be1-b6fd-4715-4830-08de8f5267ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: BhOOl0dBWXGhpjgtvSEj5yYYZxfvbyEmBePR5OMOUGlivC/h+EdxefjkClypPkriwv58VaBFQYGjHnjV4UqaJqIXzu2eC2bw0sYAdtWHKySt+rhApTAMik5kXZ5eCUmkoG1hAY50n7N5j97Zu87JuVfXO2Asc/P6u6h2fjx4bx1DtZA67EnfgfTtJ+bBajTgPcm8MraVG1IcD8vh7jXcgrIZbiozOMfZ4uySBl7hGWyf9qqcjcvX8Rvipj3yEWkZf3R/bd7ptSfPSud6op6KVt9HgqE77JchRdSNibmz9c2T3gmA9kLJpS4O9nvkZwhojeVJlRGbdskpMj6xahJREY7F7gsGMYYtUVhXCrxFjcyoZNF4IkMpeaztmyUAPoLQK1gw/agouBdc7ly7zdch10J7MxaKyv+8R2Z6IZKNhBpINuCxETrtWlqpkFdOo2rNkQL6j32PmFSVGSVOI3EhEDQnep9GSNB/YSVtnTvNN+KftgOIYVy2Rryxk5tFEthFNCNQ1TUby0hTMLf7+C5ukbT1xRlkD6QqZipf/aHiYaLGufD50XFf1fD9UHqJ598woh7Xvx5oA4dUqvQ08r5Au3oTKZR+5hb1mxGKZb26LQ+/vb5dx8Yvz2fvaAymn/KfSufdJ32AuHFtBFbhEcEMGyaOSF7pJxS6pygytS7kmBlfc+AZheNPtxqJsak563qxvB/NFAhCzwo6Teffyb/rrWG9b/ta+AqtLZuqEq38hxuhEXGwnZq+POVodB8OujzfpZHtgCQ7Cu3c6tBUTZCxY6Ovkbx+a2ubAHl6lsfz3MA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHFXa1NENzlpbU1QSVgrREpyS2NSU0d5Mk1UWW8xdDlPUi9GbjZqNWNVV0tO?=
 =?utf-8?B?YldncnRWMUhnQVVQd3BFTDh2WWtTTnFRdVV6ZUpnT3dUOVJheE16c01mUkNY?=
 =?utf-8?B?OXR0aHlVVFlab2MxeXY1OVVqUHdEWUFpeHlhNWlxQVd6QzZqSFg2bW9FZ2xZ?=
 =?utf-8?B?aTdPNDNmQVRveGhITGl5Wm9hNDNEYXgwZUo4QlI3dGpCT1lnbmhpTzZ0T0No?=
 =?utf-8?B?UlczMkE4U2l0T0tjU1RYdXNsMXZyTHpQOTlpRWUxOTE4UDBiNmtaY05FZS92?=
 =?utf-8?B?VE9kaVFtL2MweXo4Si9tZDRtaHBMM1FUYk4rdklWWnFjb3RHdm1OT2QyQ0xJ?=
 =?utf-8?B?aTArWWdMOGlPQmZ2M2txZzlXZUM4ZzBLZ0ZWcDVHdVBzN1AvTTE0eXZRQXl4?=
 =?utf-8?B?bEo0Wmh3QThyQnBWaXpqdjVpNXVVcjByVVFqbTR0OTVVdHVCeE50OVBqQmls?=
 =?utf-8?B?N21WQ3BYYU5qeURUWWxNVjg3YlF6R09ubkFjODRzSnlwTEJxWnZmbUJYaVZP?=
 =?utf-8?B?a05ONVFpVnhaTStFc2RIK1AyUVRWMktycWhXazBnOCtrTW9tWTFxSXhFSWx5?=
 =?utf-8?B?cmg4QXRrL3RaZ0FBNzhnSHoxblRYNzdjNldCcDBaOWZSWVVtbU5VdERqNVZN?=
 =?utf-8?B?Snl2Y3k2UFlwb20xZ2RkdTZmeVFvc2NFRVRIdjRPWFZqV2RvSnA0Mi84Wm5G?=
 =?utf-8?B?VnNOaDNjS0NjbkR3RG4rc1cxMmNFdklvdzY2dHd6RGtMY1RENTZUSEdvUzZm?=
 =?utf-8?B?TjVxMWkwRVVrN1V3dUY5UDEzQnlqOVZ5QlZPYUhhR3RrN01tZlJzN1NURGdK?=
 =?utf-8?B?MkppUmR4QjZLZnkrTmxkbkR2cUJvQ2NIQVp5MFpiVW8xem83TkJ2QkREdFc5?=
 =?utf-8?B?YVdJbmZPK01hQnRaaDUvQlVTWXlYdmROZVVVcTVTelptYmx2R0FyV3UrZ2lk?=
 =?utf-8?B?RUZLVitjUkgyYUNVUC93QitHY0RlTm9vUmEwZzNKdzQyaGZvWm1PdWtER28y?=
 =?utf-8?B?VEJsL3V5YXNkT1BQUnprQkhSTjRyeTh0VkNVQzhMaXBVZkFZa2NLM0Zwd25D?=
 =?utf-8?B?aldsU1YxZHRuTkRWYTBLMkYwVFdoVFJlSnJDVnlhNG9ZWmRqbFhxdGNvejFQ?=
 =?utf-8?B?MHhuVU5FTG9FRzAvd2ZxVUdyOHV6ZWIwOTl0aDU5Yk5UbXZoNjNVRURaeXc0?=
 =?utf-8?B?ZFNqVkIzKzRla0h5bEJMKzQ4ZUR4WlU5NHpobytKZVVMTTZhVmdFRGJKTFBs?=
 =?utf-8?B?MTFqNk5aSmhIbDc4M2crcUFWTVgxY0E0Q0lhUU5iRG1OK1pMSzgyYXRMa3dj?=
 =?utf-8?B?L0NRbFUyUDRYWDJwMWxHenFxR1hoeHN0WWJOaVlwRldjVEQ0T2VyTWVmL0JN?=
 =?utf-8?B?NDV5NFB1aFZwZjFCeUdTdzFxZStaR3A3OHFDbEs4K0o0bnVUR1QxSkhqUEhw?=
 =?utf-8?B?WEU2bm15TGdHT3BGUTZUZ1ZuQjkzVk9BSzQ4UEJtVHpSN2ZtSmpEaFNScXVh?=
 =?utf-8?B?MEpCVGdwK0JDeUU5WEc3dEVTdytkUUFCSWlyTjVwc2tIZzlsa1VCblRCemJG?=
 =?utf-8?B?U05Oc2JEL0VINXVRM0h4NjQ0WG1TT3BQaFhucGNFeHlvMmFjL2RVdHA5U2Vm?=
 =?utf-8?B?b25wU3RPeUE2OExrQWFlKytYOWdQM2tFTkNjYlpIUWQxZlFXOG1pQUgzdTA3?=
 =?utf-8?B?SVFhYjdlUWRzQWplTnluWFdxa3ZKek9jaTUwUDg2R0JiNmNpVGwyZEpORHpU?=
 =?utf-8?B?Wk4yNC9WdmlERVhBRkd4dTdpNFROOHB1OGRqVTZhUldsTlR3ZkZJS3E5Y0V2?=
 =?utf-8?B?aUJ6cGMyM3k5SlhCRlgrU2xKTW1kK2hIamxDWlhRMFdnajJOVWRhL0xlckdC?=
 =?utf-8?B?dzgvSG1laEN3WWwwbCt5Qm4wVDNDZWE0a2pQVjlEenBneTFCL0diTFlSNjBx?=
 =?utf-8?B?NzVtVEVDMXdxb1VSYnhrZkdRUTF2T2ZCb3JrV0tmNTdwTGk1azVmbTY5YmY5?=
 =?utf-8?B?eGVPb2QxcU9vWGpEbVFYaDg5OTJJcEZNVU5rMm5GUDNudVB3eHN1SnJpSnFD?=
 =?utf-8?B?VVNzd2NTYkRLY2FtYkJ4eGFjejA3dFFGRU5PY3QzZmQ2SXhUcXFvTWpiTjdU?=
 =?utf-8?B?WWVOazRTcUMzT0JhMm42N242bmVaZmgySE9qQytsMHJPU3JMNnFlVGowTjcw?=
 =?utf-8?B?dWpYTXRpSW4zYjRZK0dlNW95bW4vVlQyMzJORTNFcVN4bXVLT3RRdmNUUVls?=
 =?utf-8?B?TDBNK1l2cEVtK0lndldIRE05QVJzRC90Z3VkM1RGRDVZZENkSHh0YWI3Sm9N?=
 =?utf-8?B?UVZkTmszM29CaWVpemNOa0NPR0xWd2h0MDFCTm82TGMwZlFES3d3M2NGRXhS?=
 =?utf-8?Q?unVD9NckY/k+ii+Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5034537A6FFC904CB10D9F24749CA0D1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cz1j7WopXbL2GUc4GN8Oy+gRFTwO241w7cps21vfNUWZkmgoAtSWFsSrG/3X5LtUtZZKzbJ0fQafY5ZjOUbCS4e1ZSGZ40UuUf4ax0DPwkzz19NORxJJMat6BBGwjdclX0CvHkLcz82aJ9Z178hQ6Nc5z2Yih5IN5LIXl89hglUQ5+Tre2tDNEfO/Z1lTqb4LVBysz2HvUJOidh2/rfb48kL/2WLhD3STvWalf7vncNfaiMHdhFEo48ImwMEQzD0o+77F9VcxdX5iQKirhcEjX32yprwdKce7j9c3aUxn1G+t6j1JoDlhVm7D1kjOusUqoVtUvupEaX/+F1b1cOQmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea447be1-b6fd-4715-4830-08de8f5267ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 18:22:02.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JibOuk9kk38ewdkC7iozkkJTNA/q8dI9977zyHjKYm6tfKxdO7Y4khqwmKsEZBpBvnXPgldg7eZXS2k4enNo+oyH8ZCpD/lOtw9BM7aP10E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDEzOjE4ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IE9uIE1vbiwgTWFyIDMwLCAyMDI2IGF0IDA3OjI1OjIyUE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+ID4gSSBhc3N1bWVkIHRoYXQgaWYgdGhlIFNFQU1DQUxMIGZhaWxz
IG90aGVyIFNFQU1DQUxMcyBzdXBwb3NlIHRvIGJlDQo+ID4gPiBmdW5jdGlvbmFsLiBIbT8NCj4g
PiANCj4gPiBUaGUgYmVoYXZpb3Igc2hvdWxkIGJlIHRoYXQgb25jZSB5b3UgbWFrZSB0aGlzIHNl
YW1jYWxsIChhc3N1bWluZyBpdCdzDQo+ID4gc3VwcG9ydGVkKSB0aGF0IG5vIG90aGVyIHNlYW1j
YWxscyBjYW4gYmUgbWFkZS4gVGhleSB3aWxsIHJldHVybiBhbg0KPiA+IGVycm9yLiBEbyB5b3Ug
dGhpbmsgc29tZXRoaW5nIGVsc2Ugd291bGQgYmUgYmV0dGVyPyBJZiBpdCdzIGFuIG9sZCBURFgN
Cj4gPiBtb2R1bGUsIG5vdGhpbmcgaGFwcGVucyBvZiBjb3Vyc2UuDQo+IA0KPiBJIGd1ZXNzIHRo
ZSBhY3R1YWwgYmVoYXZpb3VyIGlzIGRlcGVuZGFudCBvbiB0aGUgcmV0dXJuIGNvZGUuIEl0IGlz
DQo+IG9idmlvdXNseSBnb2luZyB0byBiZSB0aGUgY2FzZSBmb3IgVERYX1NVQ0NFU1MuIEFuZCBm
cm9tIHRoZSBkaXNjdXNzaW9uLA0KPiBJIGd1ZXNzIHRoYXQncyB0cnVlIGZvciBURFhfU1lTX0JV
U1kgYW5kIFREWF9JTlRFUlJVUFRFRF9SRVNVTUFCTEUuDQo+IA0KPiBXaGF0IGFib3V0IG90aGVy
IGNhc2VzPyBUaGUgc3BlYyBkcmFmdCBhbHNvIGxpc3RzIFREWF9TWVNfTk9UX1JFQURZIGFuZA0K
PiBURFhfU1lTX1NIVVRET1dOLg0KDQpJIHRoaW5rIHRoZXNlIGFyZSBzYWZlIHRvbyAtIFREWF9T
WVNfU0hVVERPV04gbWVhbnMgdGhlIG1vZHVsZSBoYXMNCmFscmVhZHkgYmVlbiBzaHV0ZG93biwg
d2hpY2ggdGhpcyBzZWFtY2FsbCB3b3VsZCd2ZSBkb25lLCBzbyB0aGluZ3MNCnNob3VsZCBiZSBp
biB0aGUgc2FtZSBzdGF0ZSBlaXRoZXIgd2F5Lg0KDQpURFhfU1lTX05PVF9SRUFEWSBtZWFucyB0
aGUgbW9kdWxlIGhhc24ndCBiZWVuIGluaXRpYWxpemVkIHlldC4gVGhpcw0Kc2VhbWNhbGwgc2hv
dWxkIGp1c3QgZXhpdCwgYW5kIHRoZSBtb2R1bGUgaXMgYWxyZWFkeSBibG9ja2luZyBhbnkNCnNl
YW1jYWxsIHRoYXQgbmVlZCB0aGUgbW9kdWxlIHRvIGJlIGluaXRpYWxpemVkLiBUaGUgc2VhbWNh
bGxzIHRvDQppbml0aWFsaXplIHRoZSBtb2R1bGUgd2lsbCBiZSBhbGxvd2VkLCBhcyB0aGV5IGFy
ZSBhZnRlciBhIHN5c19kaXNhYmxlDQpjYWxsIGFueXdheS4NCg0KPiANCj4gSSB3b3VuZGVyIGlm
IGl0IGNhbiBhZmZlY3QgdGhlIGtlcm5lbC4gQ29uc2lkZXIgdGhlIGNhc2Ugd2hlbiBrZXhlYw0K
PiAoY3Jhc2gga2VybmVsIHN0YXJ0KSBoYXBwZW5zIGR1ZSB0byBjcmFzaCBvbiBURFggbW9kdWxl
Lg0KPiANCj4gV2lsbCB3ZSBiZSBhYmxlIHRvIHNodXRkb3duIFREWCBtb2R1bGUgY2xlYW5seSBh
bmQgbWFrZSBrZXhlYyBzYWZlPw0KDQpIbSAgLWFyZSB0aGUgc2VtYW50aWNzIGZvciB3aGF0IGhh
cHBlbnMgaWYgdGhlcmUgaXMgYSBjcmFzaCBpbiB0aGUNCm1vZHVsZSBkZWZpbmVkPyBJIHRoaW5r
IExpbnV4IHNob3VsZCBleHBlY3QgdGhhdCBzeXNfZGlzYWJsZSBzaG91bGQNCmVpdGhlciBzdGFy
dCBkb2luZyBpdHMgc2h1dGRvd24gd29yaywgb3IgZXhpdCB3aXRoIG9uZSBvZiB0aGUgb3RoZXIN
CmRlZmluZWQgZXhpdCBzdGF0dXNlcy4gQW55dGhpbmcgZWxzZSB3b3VsZCBiZSBjb25zaWRlcmVk
IGEgbW9kdWxlIGJ1Zy4NCg==
