Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795111114;
	b=KnKMGf+lCtp8/hIXk2FUec0NhT999JfIkQ5/1NJX/LHymYA+1Y4otSEhhYu9qUuEOVLZ
	 HqEWBFur+rzPgZ8553E9HznxWVhVa9SudaD4OCVftrhGw2Zto7GHnmPSlfD4Wfuc5igT9
	 Vz1n7DdbTDJ6TGjCjaSb8MhSGTyf3QwQUYz90y2Ud0KeJ3+You5lSAsixCgrK7NtR917U
	 GiGlNq/Rvlx8qfLgAYZlUFb7lfUe8ZFP86tvQcfOJk2KLM0NyPuBbydu63lokA0HjXRgK
	 NzArZ8xeWi4KEIXIyyHBgs9WASIAbS1XOvPYEtdp72POJv9R6hMfcSQFjskp+nP0NaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111114;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jpd8lTGe2Ur3cvENOIkd7Cod8NcEGFGwVhZMo7UYAgs=;
	b=kPK6PkFudiWDD5/EfwtYVgVrnBCKp4AnPKlZM8/MVXONgfuZ0EiMqw9/hieHuoDZKtIS
	 G3LVpYBQqvCRRL6Sfhm/MFRDUT8IDMFbMfTMpHu340CgJUQD7TQPbsmh2ypwZbDiHifyh
	 X6AKW0iC1ilu0Pm+os0qADgqfXJaDdM9fAeo/sQ5tyIJ8dvQt1KUMCDaJVIh0pb8j/n08
	 +1tARXUo3JVruovlqojCIFq0R8VbpieaXVLa+zwqxD+5zHgXEbfDH5lZZMGTbF6niTc+Y
	 aX5hBV9LDbSTOMWvdG8t1NT/sGhr3QM446P/yHe2Z3NE21PMvuwCHZUODobGKbUnXwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="Bxs/eyYg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.64
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5EA60A6F6F;
	Thu, 19 Nov 2026 17:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F5EA60A6F6F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Bxs/eyYg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCIXw7osXq9pfDM3EtEpH/hEWkbEAdBqegtRP0H87m5Y94mZ+LUiM5bsOTS4MdngQ/eXRPcnpJuzSdMj3LX6by6zpVT7v6vkgYQ/vnCO0mANAYxYIqle+MXp6ixImtuGaBkefD33xyN9lY0aLgdmVE4eoLc+exp/jyl+Pva0KUiPJ80H0V3kCZ+Fk8zxgS+0Ai69f++6M5xPDF+GQWqyfyM9mVNVoBu713EAHzgso0/Fp7rY45B9JTpyaDezY5VIgfTwyBX7YAd3DqVv9OJvvx+XVHNpcnF/C5qwCEOJJ63s7jz3UqAZPCF0ZrbejRK91mXkFS6/7U6BMNj9FsEVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpd8lTGe2Ur3cvENOIkd7Cod8NcEGFGwVhZMo7UYAgs=;
 b=sM0WY/RQdKHYwKZZNzoiRd6eHYhYi5BMud8XV28mJqbES/kdlmIt1Jo7LiuKHYdMsyV3Q+ubQYI23MVyEsK1OC1aaDELnY8ipOYEkrw2dKtMcM2xBmPvf3+8aUKqhTNvpXuroR9wpezP7+X09jpw1mx3E4Dhy+W3sbMQ2nl3QoCPQ8Sgy/BogaNZZUTAdLUcuOnNQh01E9ceS7oL/C4NhQtzdcepPWQkW9OpdNQW9RRtnDK6XnyHEfGsUbSDk13riq+2dRhK+j6ALSEt6NUx6NWFd4hF0xevF5XWVuj4Sezxos4kx/Bk6mpF/GFGfyBmI8LrGJ3dZkBMa3Luve3emg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpd8lTGe2Ur3cvENOIkd7Cod8NcEGFGwVhZMo7UYAgs=;
 b=Bxs/eyYgRH9J2dybykECFiGm1TaA/SphHeuJp2bxpNtSTOz3jwqZEzxCkEHmiA6mj5189q/M8nHfee2VvwtR1SNYRLdaBs4s2SlpdRAyrF7iN2aa6O/iNAhUmiVMQbz0i8sXdx+kBnnDzI8BEhO33vJ3YXDnZN7nm0r4nmkwKacD7apOfehtbJXjHraLve9Ec4fcc3F5RTxVj68EEfsYs+2P4BBXBnC3iptTKOp6CtTlIgqyFtOdFWdR1mIyJPNcFAWYO97RvSh69Oy+zmSZiZOEzFqeUcZIGu5qF9YomRI/Uv+6z4hLIrkv62GNTTPnhUZxm93BmSAyJWphAiZsCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MI3PR04MB088318.eurprd04.prod.outlook.com (2603:10a6:290:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 17:58:29 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:58:29 +0000
From: Frank.Li@oss.nxp.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-bsp@toradex.com,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/8] ARM: dts: imx6ull-colibri-emmc: Add DPI display and VGA overlays
Date: Thu, 19 Nov 2026 12:58:21 -0500
Message-ID: <179511108646.1539843.11072948008187445628.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109155751.475875-1-francesco@dolcini.it>
References: <20261109155751.475875-1-francesco@dolcini.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:510:23d::21) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MI3PR04MB088318:EE_
X-MS-Office365-Filtering-Correlation-Id: a0236c37-a518-4b7f-881c-08df4666b785
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|921020|56012099006|11063799006|261009223027099003|261021121427099003|10067099003|261102123227099003|261026121527099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4RpjdOoox3x4z9epoijzwQdWeZioKTs+8W3/kxyeMS0NRm+BNivh+rWdnR/Fvc4ZjsLbgBWHEB96mfBiCbkrm+nb24ao7Sx5LHOlS53Tn3FdgIRHfJaXn2pyRmfquwBrUuH/f3JUWLOqtHf33DSsyqDmm4EOVNx1c1kFw4Xhk/MitQsZDEmOwGdvCjdSAxt19WONLjqSLRkPGfZzq5WrQRnkkIQrqOi3cjs3cMjGpvfUfj3B4o94RFhxqFNCFDg024cReydPwDHpkJk6k9TPJCWRXWsOCc0IbuCnszWoNCrOnc+mOijGNiDcP7Qlx1DDeSYhf0op0BEAas6dteSwjMdALZ4GgjeSKVRqS34SvzB/BJ/FZnNrE6AKVSMf6FBJjlDF33tnT2s6iHJqGnW6ucDcJW2Fp4r/uOsprPTssh+Y0nawOplH2RgToo82GEpJVqU/BznVWT62eLqNX9rOJFFx/nVvpjc9DnoM0lT44nP3WHWlzyMcr5+Kqmel7wOMlvsw2sgQ64EHPQurTrvbq/nya4oFLWtPBAmINd2jAcErKKzKohHITZrGBJ2I+YsEVnYnIstkZ1gtMk1jSsuFYPI8oMfdHTEL3QJkl/ik7N2cHOWpeeE8xm4veiZvWhH1t3DxOz17mwco1VX0cSpt+lZOYHBwkILm6GIn/bA6SirLNK3TpOZq4KDFIDZB5sjxlbqIS0EtszLgw+p09Tq3Uw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(921020)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(10067099003)(261102123227099003)(261026121527099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzVPYWJjYTdvL2tMemJFMGFxVy9Wd0R1KzBPSkZtUFVOS3VwRHhiTi92aUZ4?=
 =?utf-8?B?TUNqMExOcm9KSDd1NVd1VjRvY2E1NzBYcW43Mmk0bnpMd2EzRkY1WkJjVnVx?=
 =?utf-8?B?WjROcjFQOElJRTV2d1pRWVUzb2pFWFlkVkZuRTloWktSTWdrdDE5aldZN0J0?=
 =?utf-8?B?aXZ6aVhxM2RQNHdERlQ0WVZYSHcrNFQ5emNXQ09telRnMUZ1YmlzNjlkZ1pp?=
 =?utf-8?B?NU9NWDE2aDBCL3RTdTFsWXV6VFd1aTMzREVjdDg3NUd1ODluNGd2M2JYeTBw?=
 =?utf-8?B?ejdLK21tOE92cnVDby9hNmszYWhsYy9wa2UvRzlydjVSQXNZS1FScXNxKzV1?=
 =?utf-8?B?QVJCV3hNQ2lNbWZ4WWdYM084NXJaNXJCQjYxNmE4OWR2UEVRUWZiWmhVaTJE?=
 =?utf-8?B?eEVwcXUwV1ZWUFFGOVFEVitKK3pzcFRkZVFTb1RSRjlFREVaeFdxTU5uT01V?=
 =?utf-8?B?QkcvY2lUQ3V4U0VZVEtrQ1IvYnVNMnovYzF3RDZYUVdtQ3l2Z2NuTUl1OWVn?=
 =?utf-8?B?WUdTdTB4NVcvOVFXZmc2RmEvNldudWFWRVhNUldHaG5SbDRwRGs3azdxRlNX?=
 =?utf-8?B?ckNtaDFiYlU5c3dQM2ZvOUVSc1JnTEg5cWlMVnFkeHhJdks4eHhlbm9uWC9W?=
 =?utf-8?B?bTBHV25sWmtRcVBBRjdTdzVyYjNYbC9kNW9vYkRNNmFRRkxSNmlwK01LSzJn?=
 =?utf-8?B?cTJMU3YzMkJzV3o4TE1YcWlJWThGM1pUcGZrZ2hBR2UxLzYvNHFCZm1WUUd4?=
 =?utf-8?B?dWFGUEFwOVorSHc5ZldkZ1pHbWliMU5aNWs3RXlxekVWRU1uZUt0RmEvNVFX?=
 =?utf-8?B?KzA1dWpOaW01Snd6Vkltdkd4ZzNBaHAvclV0M0t5Unk4TndmYW90NFdYNlh6?=
 =?utf-8?B?WW9IUkhSRTRsOXZRVDNPYnFUaGJJK1NqVFRjZEFkaHFNTCtIUENUQ01wRmpO?=
 =?utf-8?B?aWwvckg0K1VkU282ZE43R01LR29WdktZWWxFOU1FYmhTeFYraURWYnlFS3VR?=
 =?utf-8?B?am0vbEtQaEpjcE9EQjdxV3VPL2g2MzhuZGdVMGREU3dCVzhuV3AvZjh0UVg4?=
 =?utf-8?B?dFFmRzJOSk9ZNHRQb1EwMmdLTi9KczJ6NXhsUEZRMGFNMG9zSFZSd3ZISHkr?=
 =?utf-8?B?Rysxd1Y0WkQxaVlLNjByUFBpY216Q0h4VmVuQTlJMmJrL0IwbjhlYktaOUwy?=
 =?utf-8?B?TzhWK3BQaVR1N2tra0lRdmZEWTVVTWllMXNZL2xDR3FlZVpVSld4Q2FZNEhC?=
 =?utf-8?B?NXQwaWxGdjRQODdwZDFNUUNqQnBzbktHUmhuUy9YVitMU0ZoaTU2UkMvejdQ?=
 =?utf-8?B?aXNCdS9ncWJRRFJwelRUS1hYS1Jlc3hXN2h6WG5pR1N3TU9qSEdSTEFqZW1I?=
 =?utf-8?B?SjZKQzljWXpiekJpVE1yMXErNU52RDR0TkUxcGFtMW1DNFU4TUhYSTNFYzV1?=
 =?utf-8?B?YUEyNUlMVUxJOE52eWNGbUpJeW4xc0o4L3Fha0srWHExZHQxUnFLN3JnR0lO?=
 =?utf-8?B?czAwVm1VbG1jOTJYVGZHejVja3FpSEFBdHBEYnFMWUpvY1dGbkdyYlhlalFG?=
 =?utf-8?B?QWsrOVZoZTM5dG5wY2tnK0tYZGh6ckxobkg4ak9tNzdPK3JmTVJNTW04Ym9N?=
 =?utf-8?B?eFRPNGhtbUowR1FEWFV2MStSRHJ2V1JDZld0cXI4Z1pSOU5mSDl0aFdicXJQ?=
 =?utf-8?B?cDZxVmhHQVV6TVErcnp6QVhtdTlrdTlEZGtaUHZkOXBpeXNtWTVsemovVHM3?=
 =?utf-8?B?OHJNeEVEOTl6UzNsYlh6a3BmZ1R0NkZROUp4RkhPN1NoUlFzQnBDUEpQQWhG?=
 =?utf-8?B?RmsveXVGYXVmaDJKWHdabkxiTDNtaHZsMTdNT00wRlRQUjE3QVpHOUVWZTdS?=
 =?utf-8?B?OW9mVjh3UDdvTTZvVFZ0c3hCSWsxYUM2RWt0amh4eWxlWXhsak54em5rMU1G?=
 =?utf-8?B?NjU5QmU3ZXJEeFNpOXVLR2pBTGdxR3RTR2l3b0ZqZG9hczA0bEtiVUUxZFJ3?=
 =?utf-8?B?MzdOU3RUTXo2VFF3bmU1U1hXYkV6S0JKTnk1N24vanMyeWlNNUR6dlJJdldE?=
 =?utf-8?B?Z3hYdWhMeUlOdXlpNDlwYTF2citGUWVnaE1QanJhclk2cS9leHg4VXdDV3c4?=
 =?utf-8?B?Q3VGazZEKzYzM2dOemlUZFYzV3NVaFR1dGJyWTlBNlZtVjBiQ1VWMVp1N2xV?=
 =?utf-8?B?QzV1TzBLU1N1ODkxNlZyd1dWUDNZK1d1ZDN2RHJxQnhkRG9VOVFYWDBibi9F?=
 =?utf-8?B?OFlZKzl3aWJQbklmVkNMMlh3WDFwSWpnWEJCMXg5aXBHSlAwbEpRYWNOYzRL?=
 =?utf-8?B?QjR6dEI5Z3JvZzlJdGJhWERmZlNzT0hRZksrRmVidTVDTXhKcGExVXhnenhq?=
 =?utf-8?Q?DTsCVEjKHnMS6TfHJuKJPpM4oSVXE5CTsIZ1n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0236c37-a518-4b7f-881c-08df4666b785
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:58:29.0380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAfN2W61Pgi11lOHb/S+Tsv5C6Y3eBeM2YhWeMwahHQMyrJkIrKahQ+gEvEO0cx5P/jT6V4IhkdjPSjexoTnOdzzCV6RqhT0nxv8sXWavf9ppmYPRTgV3LfE1Z4syJ9g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB088318

From: Frank Li <Frank.Li@nxp.com>


On Mon, 09 Nov 2026 16:57:40 +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add device tree overlays for the Toradex display accessories on the
> Colibri iMX6ULL eMMC parallel RGB LCD interface, mirroring what was
> recently merged for the Colibri iMX7 eMMC:
> 
>  - Capacitive Touch Display 7" Parallel, touch on the 10-way Capacitive
>    Touch Interface connector (Iris v2, Aster)
>  - Capacitive Touch Display 7" Parallel, touch through the Capacitive
>    Touch Adapter (Eval v3)
>  - Resistive Touch Display 7" Parallel (Eval v3)
>  - VGA output through a non-programmable video DAC (Aster, Eval v3,
>    Iris, Iris v2)
> 
> [...]

Applied, thanks!

[1/8] ARM: dts: imx7d-colibri-emmc: Enable the VGA DAC
      commit: fd7a690d0e1cc9b61189a5b645805985654969c2
[2/8] ARM: dts: imx7d-colibri-emmc: Add missing touch display overlays to dtb-y
      commit: f4f84f5ae28bd5a2d88231d5c7e6d119ff35bb28
[3/8] ARM: dts: imx7d-colibri-emmc: Add tdx vendor prefix to display overlays
      commit: 07015e1df6ac41799553ffd28a544f1bf2e52f17
[4/8] ARM: dts: imx6ull-colibri: Align backlight brightness levels with Colibri iMX7
      commit: 4831643b6dd111b52f4a55217cbba0419cf35dc7
[5/8] ARM: dts: imx6ull-colibri-emmc: Add Toradex Capacitive Touch Display 7" Parallel
      commit: 91eb733b4189daa968584eae5c58932cbbca193e
[6/8] ARM: dts: imx6ull-colibri-emmc: Add Toradex Capacitive Touch Display 7" Parallel with Touch Adapter
      commit: 79ee14474d8eb4d937d7c7e778f97407786051ce
[7/8] ARM: dts: imx6ull-colibri-emmc: Add Toradex Resistive Touch Display 7" Parallel
      commit: f6ff4568045a3c14dd3b361134831ae008f2693f
[8/8] ARM: dts: imx6ull-colibri-emmc: Add VGA overlay
      commit: 909b5f1edb7da74ce6283550fa6dfcc2a6b0eeeb

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
