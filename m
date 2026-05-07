Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB13C457F;
	Thu,  7 May 2026 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162045; cv=fail; b=J6zi2uxH3x/l8kHsw8YBLrFgk3dWQXD/mS2eN6XskjOZvIAPvc5ZIU5VcyPzUEyrwLU+0WK8x5Hz/BV2tJ8WmiTYnkBWDa3tu2lVk9d8InOqav79YMsh2m8i+t+Jvv2ipuCZABnBAHEKYXg36suJihUmR+pZVRaUqmSpdQ/iH2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162045; c=relaxed/simple;
	bh=Ml3B/xwbJ773l12z5OOfFndzVl52YKTSVqPNWsczLdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ebljrVDuA1HVaf7gWyq/WKSgOLUYiPZsxM+VXMxvC+6jpD8b5mpe8r63zNljr9LWAyOAXTvX2KU009TsHkyXxdm/Epn1C1ptckxmxjMxdIZNEf1+PBSpT2jpEiMdY+nbIeEOicxdLK7URaCJaaOGiB6e2krREYTK7WdEkW8Ldtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wwzry9Bh; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wwzry9Bh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778162044; x=1809698044;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ml3B/xwbJ773l12z5OOfFndzVl52YKTSVqPNWsczLdU=;
  b=Wwzry9BhaCH19I1fRin3JqCuDJE1bgK3g9uFBe1Qxn/QyamZbFV/Xq0S
   TSykAIuIhVndOoA22VlmxwUzS6dB4ADhpyf5VVh+DV5e3k9a3PgQb+gW7
   UupSU1wG3zyRga1iJxKdLNeze79XsPNzM+U2kw8rvLZO/S+RXT6Ntl/gv
   sTIrVR6xa2DeRNs5St2ULq+Ln5QNaEa2rLBQvRRO1l0P+ybsSlfgDnj+e
   WxpRw9rhdv2LXK4ERoNEvUSExcc2iOvpX2+HH1ByvEPGzxzCkIIDey6/V
   +5+cdrTJe19y5//NU4KPlnOAbxugQj9bjyTd46exd5jksqMKxaJEhArGV
   w==;
X-CSE-ConnectionGUID: fRKUfwRiQ/aaI5Ad2zmd1A==
X-CSE-MsgGUID: j6260XwxSN6eoDlIXblsfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78828239"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="78828239"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:54:03 -0700
X-CSE-ConnectionGUID: +5yy98ylSsCZ1dQIfHMPAg==
X-CSE-MsgGUID: h30HV9TzT1G2OgnBI9xv8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="266845430"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:54:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:54:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 06:54:02 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 06:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVKdQySEYhkNYfvFUqPnbUW7PrnWvRAufJFfHoRn+f97zT8IBeYXJKRo68VK2qkUeMtzqb7QTDE1P2kAgXqxwP8KGGhn7yUvcYQk+ylP4Oy8c7hszjs+b07sh2i6Q1/JxGK2iy64Rn+8nSJ83OtGHz8NGwhLmFNeX7GwO5nY9fxvnIqEUBumx/n79bAyndHXXD+Nj7VCwkNLXtjFrqOTDyU7RmgTLlMDK4XTeLOofPlmKMeUuB0bOIbx+YW5nbkwkenRCEKj0C4X3NeLEZXQ3z+7GqAlJLqtfc2TSjFL+u4vdKcMK0NxghqadXzz9QpLy7D/+wUorSmNqeUIDFVkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLMcHr3T5Q50FzXWgIH/J1J6mcNh7JmoM5FrIEiMVDM=;
 b=SQk7Bd1BgMsrVLLImw/AE0erk6eivEqkqv7/WK1zg644NCqmazHUTGXV8J/oM+/qHiI4Qcj43QPne+AJa3F26IXoZSZT7vfY1Gn9oSTz1pCnQHVEDPx0rw8jryvx5kxtUKEuPrbZHjmwY4v8UkwtVbxn8itfxrHIzkOwv1byRIJ8hCXrjPR19eEZjciP7uN2FVy+UMNeMMuSKtmUJ7udNedOCI6lIrwUdl/XF/SV/IjrH66yBYAksx29qWL5augERd4mJ+/1xUL6XGHVfZ3Yr/MyQiwBJmuu6Ki1Faof635KrY3k/QaSW+ZWhiU8rWKYyAd9H31HVIjanWLsaBSjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 13:53:53 +0000
Received: from BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19]) by BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 13:53:53 +0000
Date: Thu, 7 May 2026 15:53:46 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin@zytor.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <chao.gao@intel.com>,
	<hch@infradead.org>, <sohil.mehta@intel.com>
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
Message-ID: <afyXgQdzdTr_JNXf@wieczorr-mobl1.localdomain>
References: <20251026201911.505204-1-xin@zytor.com>
 <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
 <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
 <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
 <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
 <afpPt7gObsyFkPRy@wieczorr-mobl1.localdomain>
 <f4650572ea8277dcde8d68e4fa5317e1abdb988c.camel@infradead.org>
 <afxm400MglHAjoje@wieczorr-mobl1.localdomain>
 <1146015e19d441f135d81f376c158c938a7ba340.camel@infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1146015e19d441f135d81f376c158c938a7ba340.camel@infradead.org>
X-ClientProxiedBy: DU2PR04CA0249.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::14) To BL0PR11MB3282.namprd11.prod.outlook.com
 (2603:10b6:208:6a::32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3282:EE_|DM4PR11MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f615290-fd95-494a-3e9b-08deac40132a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: lm0nRAG3qAPMrJZUJUH1viXBF4/+u/j54FKjHvnkBbdgBFbW7k8ggIEP+cWc6EmaokpeW23NifACWKRE9YnOR2VPNmSJofv3L8CBeHRHS0EnOs6cWVmdy1LMyjiVXCniQJUdIig8/TezJbHnIuhCWo6qp5Az1Dexr1lXZFEQD8WmtTa8n3Zx1m8FLvsHno9ePA6jjZiiiYTg92fxggI9oApAzmLTLibBlfKoX+on2RKNjy/05ogV4yx4oOjkD3zX9vd830xlnayqSE6uwMLezcccf9JEfxrlsq3DszbDIQ2gH3lb+3sItYtSIo7Wi7zebBPjgOhZu7uF4a0OQ1mg0Ci7gj6l9iVuCUwAXlVmzh7w83ryyxUtUga6wo0XeISxmzQKmrW16qNazIYN8/6ZFgqJPCNm0yPIXYjSKoKQ86pQp1dXpOmWEqf+9DTptpzqV7S2LKdkKAVnKac6GPW6SrwawYhLln5xyl1z/7UUixGzK5b79P09O/RIjFOjcjKvqEBxSry3T73osUtaIwDymWC+8sTcsFMjw4ZtE3i2t8XQX4vut4DoxyUn+lLP9O0Deq0n0pH2mXr+QnS8CnyrjXyL+OgfP7vSiSSuZ1G/gxfadVokHEGZqSFYYoD1FHxZsXnbnWuZIJE/TQmHDEA1BRxiO/LN1os24Sl8WORJy61UDRU3dWDaKNLDdbALvnqK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?U8NVdc2uZ6qMRmHt9PFDcwGEo6ZMpEwFJT24qbmQHnAzvMY3sjO9E9mKF+?=
 =?iso-8859-1?Q?8RCBEr/Lf4GPfbXXnBkuZr7mclEX27PsnsX4umw/GHtmCCqxLCRpNXHwYk?=
 =?iso-8859-1?Q?JAKWew9+KTprtSp6mJioPzG68BpE2mMpfKh0wIhmFw+y+rBFux8fR3g28t?=
 =?iso-8859-1?Q?5Xwhn0HnQnyVU/qcqpmpvCXDYK4APayg4T/PBigG5A67peE5nHx1vLIfNk?=
 =?iso-8859-1?Q?nq3HPUBz2Fe6zingaAj7eD5xhcE4vkziBm5V/3Qso1N2IuQ5T2ecfGyzsi?=
 =?iso-8859-1?Q?Ca4Ik4KUeHmmfpb3pG46rJ69XSEBpPYcqtiAXZjYeILLfUlc6FnPTU6Dt1?=
 =?iso-8859-1?Q?kP948ZYU9vGaQabzCA++n5R7nv9j+PDaM7GE47ptmQd9Uax3LCWf3V7Goc?=
 =?iso-8859-1?Q?5U3rthghU7EqXzqC+omKjIdr1GZWes44bbbZyAmHKhTEZr9OBpZs0bKdxj?=
 =?iso-8859-1?Q?zZAy6O37KL6OZcx466oBQ1tFFchuOYaVr1B4MglLxuvYKAObKU4VhYQqcc?=
 =?iso-8859-1?Q?Vv7xiMKbGJRaIFVoZ6JdeLzshBkRc1dXBFPyOIlSRy2plEXYHdbIUZ7BPn?=
 =?iso-8859-1?Q?iLSFY1VgheLpABkIKZJqGnH0tebcDq+rC52zuvBAI1jS2mPzHX+RE6zSvm?=
 =?iso-8859-1?Q?s6un7E7vrLgk50kY/EKmvfr/DP0oNVFNJLywKpZDVUay8ef9ejqM6Qn9OM?=
 =?iso-8859-1?Q?pg7JXHWOBXHZ32I/ASDC9SiK68bKcVCUpo06T5oiJC1NELwVhIoj8uDp84?=
 =?iso-8859-1?Q?Z2WQ+oLSOfFSUb6v/oGq5yx73rKUPRvRQw5nDv0hhoV/ap/lI0Zrv3w/3+?=
 =?iso-8859-1?Q?EpdMUHRnaPN32nAAMXCugwIsIl4P6mEmOIRMjmrncIeMqBld0xRPOaPJk5?=
 =?iso-8859-1?Q?mjw8bTZzRZwlxV7l2mfmXqHoGI6r/ltXCv/K8M9mmwuxOpmtI5VB+HAIk/?=
 =?iso-8859-1?Q?SFm38wtYsFqugI9Q0LT6rOP7CWJdBRNTw5Qiw+nZMC4ojzcCKUSTThXc2Q?=
 =?iso-8859-1?Q?5lmHuWutuWuloV8MXOAFuupr13fA+Sh8krvTG0JtMP0+Vr+nvORs3gzEHg?=
 =?iso-8859-1?Q?V8oVXHLMPzRq+NDRlzDBkaLO1011d9+NzAIb4JZc+ceK6BkpxjpRZG/hHP?=
 =?iso-8859-1?Q?GErPfERtpeDz+QQa0MKsHTap/0drkAHYIr+1E9mRDBpHCCN3OUTmmYGtoY?=
 =?iso-8859-1?Q?95cLcX+6zX2MgeZyKwxZMlIPu+JOR7QQSqVJXZDzYao+N57+Qn9e8sq4vK?=
 =?iso-8859-1?Q?llsTL/rmneXQNk6AbLfw4xGfVVbiqMSQZdSUGJxZQ/NZErELnfecK7Z+Tx?=
 =?iso-8859-1?Q?oa3xpjy7w3XxVitHL2+u9tdHidMxiwkYXJ7i6hGXnkCdu796FJHjyBtdPK?=
 =?iso-8859-1?Q?t8WlDbb96M9pEicQJLsekY25AJYXGBkBzphEqEf25VWBuYPFyjoxvW2gYj?=
 =?iso-8859-1?Q?NPCwjRA6TMP/bRyDO/Pr8mZgwO92c5opSmzwmGedfJ8L9YVEO6BQ5PfEeZ?=
 =?iso-8859-1?Q?9k9O04IENjHFPakqkiW8qf3YPqUk35ajUtzyAEk4JIKRVHcXnkayuHO//y?=
 =?iso-8859-1?Q?oOnqGvQQIxU47r1yTDfOIlIeuD1E7+2eSanHXFq4sIY9kmpr/WMutn1wJp?=
 =?iso-8859-1?Q?g3iinrSbZ7Z5bLhp8a7NlGdlhLrTIJsIijVqQ5ZAvqNaq6uMvyE3JTLmNA?=
 =?iso-8859-1?Q?zHuVxRSDSwZ90pWKslp0iH+GUMUqy8f8JyNVEF/OtUbLvWppRjcDx2WnE4?=
 =?iso-8859-1?Q?BWIeuy3uT6Is/KJBMtcNZT2pyIAqOfBd9NWiULOfiBisD4XP12lIZUYoSz?=
 =?iso-8859-1?Q?1c/V+nI8m7IdiDtWNb5zrzCvWUkmHYLdL1Evxw5N6Jy/czCIMrEX?=
X-Exchange-RoutingPolicyChecked: wV3n9yKyoR/Ti3cA+YO3dqij+DQx3WWcLRq9oyA5ES+yAk7shPDhr4VsCFEMePfltTMJEWdscTSee/kwm27WscMDBos8LJm/xp7Y/bnfL9mC+wVMAuWVP6tLYW+1ohXBgN/Qe7Wd/ASu5TZ+OaSeqvItjULAfcGmZPCQLvfQ2TNLt+9U9UpAWiriBaBlnB7WKN9jJClL9K3shQTyB5Qw1NDchgon8IXi4ZI60/g+5/734KWgGk+jK5yX1ctozpVajp0IYEJR+JSa3uzPXiXNYv2F3eZ8wRztXmAwSpZ7VX9zPpYIojrtgjGx58XfuUQHkhM/VVZIGk5UgG6FYtWAHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f615290-fd95-494a-3e9b-08deac40132a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:53:53.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBPMv8a5RHpUFP2lm3ulz3tYYZ5+YY8l85PuLTydEaOO6mqOINxwQ+6cwik28c1d3kGVocqs8xPxN6dcS0rgz7WvwFPfhBxNGgZE5Juqjb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com

On 2026-05-07 at 14:35:41 +0100, David Woodhouse wrote:
>On Thu, 2026-05-07 at 14:59 +0200, Maciej Wieczor-Retman wrote:
>> On 2026-05-07 at 08:49:27 +0100, David Woodhouse wrote:
>> > On Tue, 2026-05-05 at 22:20 +0200, Maciej Wieczor-Retman wrote:
>> > > 
>> > > I take it you mean dropping the ICEBP selftest test case and just checking INT3
>> > > and INT $0x20? In that case the other two tests pass after a minor change -
>> > > namely in guest_code() the expected_rip needs to be volatile as well. Otherwise
>> > > there is a RIP mismatch.
>> > 
>> > I don't understand the part about making expected_rip volatile. Are the
>> > asm constraints there not correct? If not I'd rather *fix* them than
>> > use 'volatile' to paper over it. I can't see the issue though.
>> > 
>> > Can you show the generated asm both with and without it?
>> 
>> ---------- not volatile ---------------- | -------------- volatile -----------------
>> #APP						#APP
>> # 156 "x86/int1_fred_test.c" 1			# 156 "x86/int1_fred_test.c" 1
>> 	lea 1f(%rip), %rdi		      |		lea 1f(%rip), %rax
>> 	int3						int3
>> 	1:						1:
>> # 0 "" 2					# 0 "" 2
>> .LVL42:					      <
>> 	.loc 3 159 2 view .LVU146	      <
>> #NO_APP						#NO_APP
>> 					      >		movq	%rax, 8(%rsp)
>> 					      >		.loc 3 159 2 view .LVU146
>> 					      >		movq	8(%rsp), %rdi
>> 	movl	$6, %edx				movl	$6, %edx
>> 	movl	$3, %esi				movl	$3, %esi
>> 	call	check_fred_event.isra.0			call	check_fred_event.isra.0
>> 
>> I think that when the FRED event happens it doesn't save RDI and overwrites it
>> before going into check_fred_event. In the volatile case it is saved to the
>> stack before check_fred_event() (.loc 159 is the check_fred_event() call).
>
>That looks OK to me. When it calls check_fred_event(), expected_rip is
>the first argument and thus lives in %rdi. On the right hand side where
>it's volatile, it gets explicitly loaded again from 8(%rsp) for the
>call to check_fred_event().
>
>On the left hand side, the compiler doesn't mess with it at all; just
>chooses %rdi as the register to use for the output %0 of the inline
>assembly. So it's loaded *directly* into %rdi by our 'lea' and it goes
>straight from there to the check_fred_event() function as it should.
>
>Your version turns it into a memory operand and forces it to get
>written out to the stack, after which the compiler has to load it
>again, so yes it'll look a lot more like your right hand side.
>
>But I don't see anything actually wrong with the original.

My theory is that after 'int3' call the FRED event is handled elsewhere and %rdi
is not preserved. So the original version of the assembly looks okay but I was
thinking that int3 has side effects.

Below is the test output of the RIPs not matching when running the original,
does that help in any way?

Random seed: 0x6b8b4567
Testing FRED event types with EPT fault on stack
==== Test Assertion Failure ====
  x86/int1_fred_test.c:114: fred_saved_rip == expected_rip
  pid=193114 tid=193114 errno=4 - Interrupted system call
     1  0x0000000000413319: assert_on_unhandled_exception at processor.c:659
     2  0x0000000000407d06: _vcpu_run at kvm_util.c:1703
     3   (inlined by) vcpu_run at kvm_util.c:1714
     4  0x0000000000403104: main at int1_fred_test.c:209
     5  0x00007f90b3c2a1c9: ?? ??:0
     6  0x00007f90b3c2a28a: ?? ??:0
     7  0x0000000000403314: _start at ??:?
  0x40446b != 0xabaf80 (fred_saved_rip != expected_rip)

-- 
Kind regards
Maciej Wieczór-Retman
