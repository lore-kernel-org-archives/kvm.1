Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA471481A98
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=63.178.132.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808284; cv=fail; b=XhKiD7QFB0ItVl8g3Olyx7NneWnBk9jP8ckvCJV7ghVc0NDu/AW1na/b0x58813X4pX8gp6F+J1X8vI5OKp/Owf5t+wS5MYKxvT7zEfCF+drKuJmK9JLxJL6w9GLWmA6ZBTjekAwU9LcALa3dqXCyTcAz9fSo9rCxdAxZk1hMH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808284; c=relaxed/simple;
	bh=40lB/ZpSqNB2mUgLc/G1Z9FbdvS9ltMEBnM30UJdMpw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P0wouNqA3CqN+hmSDgtF7qxykChUBBBNbnRi6QjO7F1JiNCokEiD8i+VSyiw7AP+P3fcirGOMTRJ7DB/4NkCB115IcBv+/5y5jCRk2wasauK8mk2aWgg4Ne03TM5/wpUribtxOaO/AOiDrhtK7pgrs1WKFdZv9vGxVIgQG7OZdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=QZ3Wdx9r; arc=fail smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="QZ3Wdx9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1784808283; x=1816344283;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=40lB/ZpSqNB2mUgLc/G1Z9FbdvS9ltMEBnM30UJdMpw=;
  b=QZ3Wdx9rNzULpdDNJPxrGbTJUZpXBcxSgPHx4p+H3wi5RVJ2mPf/gQEx
   IVIfJTuk3dr4p0ZOv19V9lwagk2EyG6/+6xlBBppWslbEgzujz4QTb3x3
   pR4w7fjA9xyhMUaRhGBy4lIYyPg4i4efrKLqGARxxpWbl8OLKXT+MgVkx
   aalfPr7tJjw+Gw2S1fS/7OdTgUsa8doK6hK7u6ejgUFStaUlMGVO6/yOf
   P0Uc0REGlUvCP4D5BAEVEjCzqTFjI/DmSSWxak3sBjddRpSc49AyVA69Z
   VsWq43T4ix8lajPj7RrLNnSux2sOUeXoKE/SmxIw9potYey8gSM39spzG
   w==;
X-CSE-ConnectionGUID: vsbi98LmTPiwG/Y9mrmzcw==
X-CSE-MsgGUID: 9Io6pDMeQlWlHtbpoWI/nQ==
X-IronPort-AV: E=Sophos;i="6.25,180,1779148800"; 
   d="scan'208";a="16728723"
Subject: Re: [PATCH v2] KVM: x86/pmu: Add module param to batch emulated-instruction
 reprograms
Thread-Topic: [PATCH v2] KVM: x86/pmu: Add module param to batch emulated-instruction
 reprograms
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 12:04:38 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:14174]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.4.185:2525] with esmtp (Farcaster)
 id 33b0d446-fc08-4b45-bd5c-c525ecfa9fe9; Thu, 23 Jul 2026 12:04:38 +0000 (UTC)
X-Farcaster-Flow-ID: 33b0d446-fc08-4b45-bd5c-c525ecfa9fe9
Received: from EX19EXOEUB002.ant.amazon.com (10.252.51.83) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 12:04:38 +0000
Received: from EX19EXOEUB001.ant.amazon.com (10.252.51.80) by
 EX19EXOEUB002.ant.amazon.com (10.252.51.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 23 Jul 2026 12:04:36 +0000
Received: from FR6P281CU001.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUB001.ant.amazon.com (10.252.51.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Thu, 23 Jul 2026 12:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gk70PqhudK3vjeZK68Os9OsQVt6YwtAqi0pW/pZ9v5piWA7zAlGCnnM01L0+6Vh/q+BVmrX3z9jRaBjPkl+AVWLKBWNm02cvA4xF5dfLoYbTViC3YWsJd5Wa/52/sy6FDP0Bbb1MGR85SYcufC0WeMNnrRY5Q8AXJlUZL3eMmcwvKQgJwoDBpQZQpaeLrepDxjLW+ubWmeBjuoN9U3XZ/0PyOvMMEKjE10iHDHYmQwzybY93VVhprJ/SHQ2wErZtSVo++nPit1VSUomhpUq+zUpfLO22UFAYkLz0BaN+KG2WGacH//x4JgXbyCNOX51Z0A7if/WP0Ix+HgZSU+ZRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40lB/ZpSqNB2mUgLc/G1Z9FbdvS9ltMEBnM30UJdMpw=;
 b=He4jMjuURspS3oebr/Y/ObtRKYAWQ69wAb15NTGnHxeR9UTT46QR8xnEUO0YS1sxsCIVgtsMwgPegHunS3aJp1DddQepsw6dJBcZG1AhvkWp1RYgQHgIYugaKMJXuQkOzlUJ5KdDI0hxB40yEM4XiNZaYMDZJnUzSWqZmi4CMx7JcMyB9RpEag830EdpIdNtxouY9maqnSzRExO/55phvTOVcLoyeFalV1xBDyZYwFNYJgOsj2oD2o0boWfGveolswDGSyOcd7LLursXkmWXn97ePrxX/mmsieVA02kMz9ccJpdlPIf+e3zAbYmYbu1Mj8MQoGIK6y7cDr6wu0yo2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1bf::23)
 by BE3P281MB6369.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 12:04:34 +0000
Received: from FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1c27:e30e:1c73:ccd8]) by FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1c27:e30e:1c73:ccd8%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 12:04:34 +0000
From: "Absandze, Luka" <absandze@amazon.de>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Thread-Index: AQHdGpGOlknDX2R+5EaHaarTphCaY7Z69NwAgAAM2gA=
Date: Thu, 23 Jul 2026 12:04:34 +0000
Message-ID: <amH7Ncv35GsM1P0A@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
References: <20260723105309.12145-1-absandze@amazon.de>
 <20260723111839.1385D1F000E9@smtp.kernel.org>
In-Reply-To: <20260723111839.1385D1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR6P281MB5787:EE_|BE3P281MB6369:EE_
x-ms-office365-filtering-correlation-id: ea832154-374e-45e0-67b4-08dee8b28fcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info: naf8Fj7c8/N3Y48IjlHQ4OKCbU5jRmN3s3SgN6+n/47oHZi5JSr9s6xr06JgajRLoLfHDxKYJFvH8M1lID3CzYUNQGaF5O8V6PXmEPZtF8drAwPDPvebEfIPrUsc6kn+/oyOSD004JX2FUfZJK4ulxYVZ+LMNyw0WzBQbdUX/9JHsZkqnISC1rMTB2WBcdE/Ys5azKlJlwGDDN69Awuco8IIelv0tx64zGOPlOLeau1Vs0qIIoIFGe6I6YXQOww5gsxtHBEoeixWAjiceSUOt/wKOOkb1IoIy6k8nZkqyQc+Q19T3n/Jv9hndZ8j4F7ZRZ7KfdkIV7debNSaR9BESMrqyGruwnlczt8zOfJLfqhG3t4d+ohZrCDq2XscMbqyzqa7xVyrADBN78vOoZ0VhSrm0ebVMVaGYGZ1ITbBVO+pzsiZ8hJFBdeUFj/HbScvMFGTL3zvTE/fz3+5Sr1fQ1ap0ykfh36TJaSHGD2h9IrOk90iTyhcOvXjGYeE8hiSUTZOv4qzGlg2U7+9FZVmF3uCZROyPyv7ofGkNghSAqfu+DIUJfAWtXiFVh0SjPenqeIpJoYkKlEEWTwjvgpVFuvMZBXkW7Mb+qHpplH8mSa8+L2eP/zfNFpgXqT63u/vYfCJ+ccPo2bErFdhgo5DMMK1UnfRME7FT0FQb5/KCn8g4NuaCfxbkb/dpddtEkOk/Q2ZwX2nx6mia27fbTCbWzMY/vVhdQDk322CXysJqSo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEc3QjM3RFhtRGhib1p4OUR6eUlrbXRMcmpINUlnRTgxTUZqanZ4OU5pVUNB?=
 =?utf-8?B?OW9hTklyWmFocE85S3pXU3ozQUFXYXpPSkdHWXF0QU9QOG1NMEZVcVFEeFA3?=
 =?utf-8?B?OWNDVlhDV1V3aTVodTlQUU04VVNKRkpCLzAwSU1hOUxTei83cWNqQUNDdDBw?=
 =?utf-8?B?Q2RzY281ZVRCUkYvakRPanFhVCt0QmlRM2ZoTVVjVzBFVmhTblNzV0RUNjZP?=
 =?utf-8?B?Q0k0TUxxa2wxZEFXeWVES3FRQXBhWG5rU0t3RTU0L3pZakNXQStpOGN2S3BG?=
 =?utf-8?B?WEVEU1ZMaHYzRTViZnhqQmJMSzVQQ1EwVFo5RmREWTZMa09tWDJ3dFBJRUE2?=
 =?utf-8?B?bW9IanVMTFUxaDV5NFhSajRQejRFeEZ0WnVack5EeWhJWk9pWmhuc1B4a2ZQ?=
 =?utf-8?B?ZElDc2lwWVh4Q0I3OStZUFVLTFVjci85alNTKzlMUG1IVWtUTzY5c2prRXRQ?=
 =?utf-8?B?WWhEcXUrbEpGZk9MamdJYm9CVUJVb3lCMDRrcE4vV2dlbEN3dTY4UFVqbHJp?=
 =?utf-8?B?MkM4LzFpVEVoZWN4VkRXb3RjR0tvMWZSMHB4TEhYSXpGbk1mNHl2Rjk1eUZv?=
 =?utf-8?B?VERQNG5naFlVdUFoYlNSREM0dTd3SnhsWFVHaHladVZuL0pGQnpFdzNuN2tl?=
 =?utf-8?B?bmhQeERNazAzcHIveHdTT2Z4Y1FGTUdkWjZ6M0NNT2pVS29XUDVxbU5Bc0JJ?=
 =?utf-8?B?T3hVRytFQ2grU1Z5QnhJUlRhcDBjMnU5WVlySkRHTXBTWUovOWFGZTNuR1lZ?=
 =?utf-8?B?STIzY1cwYmI2ZHJjMnhkSFV2Y3dOeXVHbWQ1ODNPK1BOQVMzVEk5SDRBbW54?=
 =?utf-8?B?d2plY1RXaGptb0N4anZObUtsa2dVbVRCLzBkTWZZVmdjQzRFSmErWVBjM1JQ?=
 =?utf-8?B?WEdsQ3FoWnMzSEFIaXloOHoyeWw1WVNMU2RvaG5nVW12N2ZPM0xiTGFMcGw1?=
 =?utf-8?B?QS9nY2M3aUNNdkp0bmNRWmR3Mk9MTWkvbVJUcVlqSDVzWkFmQXpVdmpwZjln?=
 =?utf-8?B?RkRzQmN2Yk9oakgvc3R5RHpFelN2d2V5T0M0dm1UOEFYb1BNS24rN3N1M0w5?=
 =?utf-8?B?S3Jya283cytjWlR6NS93L1pWL01aQWdnb09laGVGQklWQTFBbXRtOVYyQ1Mz?=
 =?utf-8?B?Rk9ZR2JTUGhpZ3hXSUkxQU8zVGtnVDFJZ1Z6SFhMdGtLQzdWVVNRaDdyVkhi?=
 =?utf-8?B?RkRaNFdjSHlodTNEaWs1U2hPY2c4SVlrYVQyWThwKzhyOXhSSmUvVGpwSUF4?=
 =?utf-8?B?amRQS05iTmJwVjlvSUZnQVRxSXQzcnIxeUYzSU1XbE5hSjlqMXNNb0p4R2ZS?=
 =?utf-8?B?VGpHT3FFN3BCdmRBQlR2Zm8xaEZhbXFmV1lkandZbmZvVVkxZzczdlBNWFBw?=
 =?utf-8?B?V0lib0NFK1hhVUYwcUVjeE94V2V1ektnbm0vTUNyRmRYYU1hSG9NR0VVVlVm?=
 =?utf-8?B?ZVUwNDY1YmFXMFhreklDZ3F6cWFJSkFQM0p2K1Nwd2VjQitSQVdzRlNUUkFy?=
 =?utf-8?B?Q1h5YkV0YnB5b3BqazZrU0FxTnJ0bmxMUGl4OUJzRk5kTWxjVWp2a29hOE5w?=
 =?utf-8?B?Ty91M1Z6cy95Tk9lMWRXTUtTc1dUeHdORk85T2JPZllLbGJwdWM5MEN5OGw4?=
 =?utf-8?B?L1dWZ0VLRitQTHplY0lHb016YkhWZnE1ckJGL1pCUDc2TWFmRHh3NG9vY2RI?=
 =?utf-8?B?RTN3UzZmUGxTa0c1azlnNW1hMzRBdzhLVjd4cFZKdTVqSzV6NVg1YVRTT3lr?=
 =?utf-8?B?S0R5SzNWQ000RllUV1FxeUxsclgxc09xZE9ySkUraWdyTWQybjdCVHJBK0Jo?=
 =?utf-8?B?Q0FYWEk5MFVCZm1rbTI2RExxZ1RUNG4vaEsxM3R5SEsrdmhXT1V5WFFnSjZH?=
 =?utf-8?B?UlowT1pMRnBjdEhnc3hrUGlwVC9RVDZwSzNzREVGblFGQzJqckpNbjBYc1Bu?=
 =?utf-8?B?K0t0c052YTJzY1V4M0RZTlRmNGlGeVBBRGRmMkFST3BQNEdPSHMwemoxNk8r?=
 =?utf-8?B?c3g2aWdvWDJQRndFem94Q1pNYmwxcWpFQWVnK29VRlhEOW5uZTQ2NFVDWnBT?=
 =?utf-8?B?bFh5emdBQmg4eFpCOW1EdjlHaEtKdVpHUG1FNVlHWEtrenV0Z09iSFkzTmRP?=
 =?utf-8?B?N2dRT3M0c0d6ZURBaWVRNHZwVktJQmpOK0hibExESGlnNm9wNjZ1UXVWL1kz?=
 =?utf-8?B?L25PbUdsYWRjdFM4OWg5eVhIeFFKRGRBVTRVT3VHUnZLVUN4K0VPSytsL1pv?=
 =?utf-8?B?ZXFEUzBvZnAyMXFZRFJSMGlrcklwTnpUK0VjSTBGQjg2VERHZUlpK2RVanhM?=
 =?utf-8?Q?KOfhzzyhdDrzwENJOU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35635536830F6A428C5C3E1BE5F02A42@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r6ofvo0l7NfjsDv7ULuHl8F7ahKU29JIb+iJRZI5SjCghsbYeEOd+7/fKeq0JSyG7uJ6MR0KcYYe6I6PehdgWVvzOWDtENlrZitcGmNEuW2Ejclr5zuc7VYVr3LPhhbmKqWKkDF8G33c3FTZ55loJTSv2o0+ja4gC7iRPlCe/CfTRi98w4HmiyJD8MbQj17ER4E4fG+KrFXfa9tOCv6ZQfUY+AQfhmkaetqlzfRvP2ayue/0Z6Jqs0F2X8IJcC0eU6sWCo1QUxJD/ve42mciSB858lz9lynnRBp1t0HY1nugOCMEdrfD02EswKOzU9uOb8Ngc48UbAG/91keq8sclw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ea832154-374e-45e0-67b4-08dee8b28fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 12:04:34.6536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a49AewkDPe+eSsNnEXu4iDliaFuGugeJSK8uMihs3vUuiXMRzxg3UOD0gnKymc9heN4bpYo0jGhMN8hizXyikA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE3P281MB6369
X-OriginatorOrg: amazon.de

T24gMjAyNi0wNy0yMyAxMToxOCwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToNCj4gVXNp
bmcgUkVBRF9PTkNFKCkgd2hlbiBhY2Nlc3NpbmcgdGhpcyBzaGFyZWQgbXV0YWJsZSBzdGF0ZSBt
aWdodCBwcmV2ZW50DQo+IHBvdGVudGlhbCBjb21waWxlciBvcHRpbWl6YXRpb24gaXNzdWVzLg0K
DQpGYWlyLg0KDQo+IFtTZXZlcml0eTogSGlnaF0NCj4gRG9lcyB0aGlzIGJhdGNoaW5nIGxvZ2lj
IHJpc2sgcGVybWFuZW50bHkgZGVsYXlpbmcgb3IgZHJvcHBpbmcgb3ZlcmZsb3cNCj4gZGV0ZWN0
aW9uIGFuZCBQTUkgaW5qZWN0aW9uPw0KPiANCj4gS1ZNIHJlbGllcyBvbiBwbWNfcGF1c2VfY291
bnRlcigpIGR1cmluZyBhIHJlcXVlc3RlZCByZXByb2dyYW0gdG8gZGV0ZWN0DQo+IG92ZXJmbG93
cyBhbmQgaW5qZWN0IFBNSXMuIEJ5IGRlZmVycmluZyB0aGUgcmVwcm9ncmFtIHVudGlsIHRoZSBh
Y2N1bXVsYXRlZA0KPiBlbXVsYXRlZCBjb3VudCBleGNlZWRzIHRoZSB0b2xlcmFuY2UsIHRoZSBs
b2dpY2FsIGNvdW50ZXIgdmFsdWUgYmVjb21lcw0KPiBkZWNvdXBsZWQgZnJvbSBpdHMgb3ZlcmZs
b3cgc3RhdGUuDQo+IA0KPiBJZiB0aGUgZ3Vlc3Qgc3RvcHMgZXhlY3V0aW5nIHRoZSBzcGVjaWZp
YyBpbnN0cnVjdGlvbiBiZWZvcmUgdGhlIHRvbGVyYW5jZQ0KPiBpcyByZWFjaGVkLCB0aGUgcmVw
cm9ncmFtIGlzIG5ldmVyIHJlcXVlc3RlZCBhbmQgdGhlIFBNSSBtaWdodCBiZSBwZXJtYW5lbnRs
eQ0KPiBsb3N0Lg0KDQpUaGlzIGlzIHdoYXQgd2UndmUgYmVlbiBkaXNjdXNzaW5nLiBQTUlzIHdp
bGwgYmUgZGVsYXllZCBieSB1cCB0bw0KdG9sZXJhbmNlLiBJZiB0aGUgZ3Vlc3Qgc3RvcHMgZXhl
Y3V0aW5nIGluc3RydWN0aW9ucyBhdCB0aGlzIHBvaW50LCB0aGVuDQpzbyBiZSBpdC4NCg0KPiBB
ZGRpdGlvbmFsbHksIGR1cmluZyBsaXZlIG1pZ3JhdGlvbiwgS1ZNX0dFVF9NU1JTIHNhdmVzIHRo
ZSBjb21iaW5lZCBjb3VudGVyDQo+IHZhbHVlIGJ1dCB0aGUgdW5tb2RpZmllZCBHTE9CQUxfU1RB
VFVTLiBDb3VsZCB0aGUgdGFyZ2V0IFZNIHJlc3RvcmUgdGhlDQo+IGNvdW50ZXIgd2l0aCBlbXVs
YXRlZF9jb3VudGVyIGltcGxpY2l0bHkgemVyb2VkLCBjb21wbGV0ZWx5IGxvc2luZyB0aGUNCj4g
cGVuZGluZyBvdmVyZmxvdz8NCg0KVGhpcyBpcyB0cnVlLiBXZSBmb2xkIGluIHRoZSBlbXVsYXRl
ZCBjb3VudGVyIHdpdGhvdXQgY2hlY2tpbmcgZm9yIGENCnBvdGVudGlhbCBvdmVyZmxvdy4gU28g
eWVzLCB3ZSBjb3VsZCBsb3NlIG9uZSBOTUkgYWNyb3NzIG1pZ3JhdGlvbg0KaG93ZXZlciB0aGlz
IGRvZXMgbm90IHNlZW0gdG8gYmUgbmV3LiBUaGUgc2FtZSBzY2VuYXJpbyBjb3VsZCBoYXBwZW4N
CnRvZGF5IHdpdGggYSB2Q1BVIHRoYXQgdGFrZXMgYSBWTUVYSVQgYW5kIGdldHMgbWlncmF0ZWQg
d2l0aCB0aGUNCmVtdWxhdGVkIGNvdW50ZXIgbm90IHlldCByZWZsZWN0ZWQgaW4gaGFyZHdhcmUu
DQoNCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IENhbiBkZWZlcnJpbmcgdGhlIHJlcHJvZ3JhbSBj
cmVhdGUgYW4gaXNzdWUgd2l0aCB0aGUgc2luZ2xlLXdyYXAgb3ZlcmZsb3cNCj4gZGV0ZWN0aW9u
Pw0KDQpJIHN1cHBvc2Ugd2Ugc2hvdWxkIGRvIHNvbWV0aGluZyBsaWtlOg0KDQogIHU2NCB0b2xl
cmFuY2UgPSBtaW5fdCh1NjQsDQogICAgICAgICAgICAgICAgICAgICAgICBSRUFEX09OQ0UoZW11
bGF0ZWRfY291bnRlcl9yZXByb2dyYW1fdG9sZXJhbmNlKSwNCiAgICAgICAgICAgICAgICAgICAg
ICAgIHBtY19iaXRtYXNrKHBtYykpOw0KDQogIGlmIChwbWMtPmVtdWxhdGVkX2NvdW50ZXIgPiB0
b2xlcmFuY2UpDQogICAgICAgICAga3ZtX3BtdV9yZXF1ZXN0X2NvdW50ZXJfcmVwcm9ncmFtKHBt
Yyk7DQo=
