Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB2377A87
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887360; cv=fail; b=QaT/jpF1AfEOlRYPW44hRpX3G8Q52fS1bsvuZDFZCvcyTI19IPE1wlQrEwF4y2Qrb2iMNbEy01+HSCtlk+QTsR7P9StdofPst9gyVm7HaYl7AKWAZj08RiAcLx2GTPryU/NSo5VEbJGaDw+hDZZX17yb8bT2U9Zm+LburOH/S9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887360; c=relaxed/simple;
	bh=ly2cIxTpaRrWRFjwITxwEOsFSFZN9qNdNFHEuWHpIjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jp82HadkBxxokoU9FsAkYeTj2DUWqiqx8y+KV9HQ+7XncM72uMeRYPk8tLeTP03/jVxxu7h97IdBK6b2ANZPBv/arizMl9thDPZB1U/5C/aY9FcumQ2hK2holUbKAuW4kMK5r3h+HYFnK7qr3fI8I3TqHQK8fRiHBNDuEdTfF3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oeIokW+O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KZ+XRfk5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oeIokW+O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KZ+XRfk5"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O80RDn2132121;
	Fri, 24 Jul 2026 10:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zTWwGV3WayeXd44gRPYkdAzyc5WWIdzHaDhFPcjTDhc=; b=
	oeIokW+OapUhKsjY1e/GSWGLg1Em/0gXE93lI/bnASLIptcNMKdT2ubcECmjvUWF
	APJxjB03JVOH1y2/S9UHYXluzGFryjB8s4GkY47h/KHLxexdXlUgikfzdA4vK2kf
	NZxP+RyZFYVzT/bT2CDARGLWb+8jq3PRt4xKYlxOyr0xgkU2psXvexplVBYFgGe4
	uzJ+a6YP4bXnhyEJIF/GMzqetvBNndAVSp95cNIQhxvi+KwO2O5NF7EP3ZHG7FoZ
	lDMkwKpq5VeoJkY4R9szZHS/kcvI9q8RHJrZ/h+Gyy1QF595grfiUsincOLgF7kC
	gev0F08hOl6SkoxCodyhBw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1n38g3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 10:02:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66O9w92w007826;
	Fri, 24 Jul 2026 10:02:21 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxfuh2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Jul 2026 10:02:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9E6bEl/0L/Df0JdlsZqOfoQnJX7U5Divc7AwNnDWw6uJ982r8N8fj+8OH0gqHeXFmwDh0PJNEZrNNAzi6m4HvP56iT0yzzkYYRLtckUgdUcO2YmWUd81lRrbSgtQfNRpNwkoiQ1E4XRhLRBYWOdkpb/38BSOYvHyTzlH3YifMNEKTAPCyRrgoQ64mh685HAKPo5EeanoSz9aEaowo6LOETV3uAzkSnpd9GuTljpDyS04p8UmA1NPMfAFT6rE2PhicBFdHxMeSDtvabff+R067OzG91nB4iUkDNBpeLkSJdEOE7VKoqF2bdgsLA7L/Yld4LaDaDNlFuUgk7cQhq0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTWwGV3WayeXd44gRPYkdAzyc5WWIdzHaDhFPcjTDhc=;
 b=EmL2bZeO3Uksr5fZCWo0HET8GVlFrkiwXsdc63XzEvOW6IJWlEPnnmtyMIPbJhwK1Qr/4CMde/twnJam5Tuajg+EA4vsY9BblLUuKJz4Y3/AcstFFZVONJVsccGmGh8M9AbQSqI0+DtqHVYZx2rDSBTI2INkK1DcrVcDeCtsEoECK3wj6PnuvE8VKp3PiYqMCLM/2NhDT+Q5C40cmwUe0lgagyYE9y4CxisX+ptNsQr7fjq9yhKw2H51nJuD86gU0REbECPL0PQcseUzrLGkkQqnq9pO6ihrYi1xriQARNCOyFqbBPAD1umJqgLzMOroL3tTD9fW48Hsikm+xvGgiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTWwGV3WayeXd44gRPYkdAzyc5WWIdzHaDhFPcjTDhc=;
 b=KZ+XRfk5EZZGHzLOc+Lx6fOO5IXbE78QwDPxOvBqKOcWjQKVhW27IMhLMDwLtrjS1Z3/a6UdxBIbliVhpYuOz9l8lFB8tO0k/S6hOJy1y8vfnDaOrywMfikohf7Bs8P0n2euBNvAnCq16ADhxYid/1vIKk2dddXffms7FetsbnA=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by SA2PR10MB4571.namprd10.prod.outlook.com (2603:10b6:806:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 10:02:18 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0245.009; Fri, 24 Jul 2026
 10:02:18 +0000
Message-ID: <9a03f63c-24d0-47f9-8e8c-d754f8f51215@oracle.com>
Date: Fri, 24 Jul 2026 03:02:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD
 PMU getter
To: Zhao Liu <zhao1.liu@intel.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, mtosatti@redhat.com,
        dapeng1.mi@linux.intel.com, sandipan.das@amd.com, zide.chen@intel.com,
        joe.jin@oracle.com, qemu-stable@nongnu.org
References: <20260325021236.14574-1-dongli.zhang@oracle.com>
 <aigek5eqJr6DHZau@intel.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <aigek5eqJr6DHZau@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:510:23c::25) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|SA2PR10MB4571:EE_
X-MS-Office365-Filtering-Correlation-Id: 910912d6-4431-422c-7fda-08dee96aa35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	uZ2elEkE+iq/cXeXJUfpwlmjf1PygL/dsqpsysPgpejBrJcZDVjUvytjcf6vCQMxjIgzCR3yDVKrpBpyqg72Eo2fTS41wd3CoLxKUIM217OB3MqEUEckfcfPWJ9UhP0fv8iSDvf8IkL3kBMZ/gJ3LOgE0Kllba0pw4gNunxVECSS0KzbjCyY9GFdEP+8hBScmh5d5jdz/ezimwCgDApJfiHg3pNQcOv4ibB8GbzdD0HFesQrmqKOeQNUFYMqgO9FSW4698t+OX5hZgXq5+Bgbfr7+pLRl6vvEQiahTORxon5O5qEbQsvbgESqZ8e2Gs64hD3t5/OCnGJuJkof453doT2D9VBYPvZKRKloKg73KrcnFw40ngPFkkMCmnbQqIMMPqeRQ7j4BZuk4eP154cJoptjN9ipGSkpjtOGgd22jSXfvt2Z3KUadvmstg3FUl8AE318OrU5gWNMUTNC7ipo/UuuitEFxaDQDOWYTVPHiqFhnnT9nxtK7ZOQF9BjAVvLswsmJHSlfS/of5xbw2K+0rMH5LEgxe2l/0LR37aa6l2OJWd9sTSSBHjSmyhNkhlPai4DtQBdi7ZeY4pTyisoWb7jdARi6QJ2GHXRl3nLx3QIBJHwO2HbG5vzDTwz/6vQquZf5v47IP4Gf2VM85LO4b+l+zZjAP8xd4XQ8vlVFk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCtWUDNpM3M0RmhkbWpQTU56YVl3TzRPSEEzT1hxWnljSFAzYjRRLzlRYXNo?=
 =?utf-8?B?NmtIcnJBMFpsR1ppZnVBN1VERCtWdjZjaGtwKzB5eFVERnZlUmhwM0hXRExC?=
 =?utf-8?B?WVVBdmFmVW9PSkxDZlQ0ajlkenJibHNGanFGVmZRbk9sWDRpLzJvek4ydGw5?=
 =?utf-8?B?UW5tTVVzd3NIVVdBQk5rT1R0VFNWcVRRL0hzVGxVWFdTYXdTQ2xXdXJqU0hh?=
 =?utf-8?B?WDVGSGtwTjQraHRsc1E1ZEpkT05wQ2tpMXdqOTRxcUpLTkZFckR3V0VGUFJG?=
 =?utf-8?B?Z0JlRit4a0t3MUMwT0FFU0l0ZkRxVDdMc0xOcExGY25YNEIrUVkwYzVqR1Nt?=
 =?utf-8?B?RUtUQkxVRmtnRVJRWkY4dFRJVDlvRGVKNzFic296UFE1NU9VK0MrYkZtRUEw?=
 =?utf-8?B?S0ZtN2w1L1l3b1duMWJKWXptbXM4S2ZMRFozS2Rad3AwMjFyQkZpQ1NzL1hW?=
 =?utf-8?B?dWo3QldVVlBaT211c0tPaEdaZXN1Q0Nudlk2VWxxOVhuSy9iRGhSYnI5N2JD?=
 =?utf-8?B?bEpLSU1KQmNHS2VOMVh0VVRkNjdWQTNCbmV2MFUrZ2taWGN0TTUzQXBkRGw5?=
 =?utf-8?B?L3p5VG9vZCt1NWJReWRqWUwyUTZMWmsvWUFWKzJlTW1aTVpEREVmUXlLdGo2?=
 =?utf-8?B?cGVGV1pVMmpXbjI1ZUlhMjdUZDkxaTEwRThFOTZXeFR3azJzSHJDNWlCZ0pZ?=
 =?utf-8?B?UzNKc09acFQ5N2ZBRzBuK2VVUlJoT2JwTGd1ZVFQSGszSnorYnVlRHpsQkFs?=
 =?utf-8?B?WWVpTjBwa05nRGhiWEh6b2Rla0ZhTUNHMmtBZjlNclVYVVdxODFISThmV3M4?=
 =?utf-8?B?UmxtSXNsamJVTEptUytvVlY5VmI3U2NiTEdGOGQwKzN3MzZzYjhWVUJTa05N?=
 =?utf-8?B?ZmdUaWU1cHVWckNPTVZOOGNpZ1M5U1JBVUhmdmR3WnM3TUdrcHRuTkZCV1dx?=
 =?utf-8?B?a3pSMXpKNFNIeGNTZm5xOEJmbmJ5QUJXWVBlWTNVazFtNjlCMWNMdnY0ZWdp?=
 =?utf-8?B?WklmVUFyTThWVzRNNEM3SkZTdUpOZCtYc2gzTHRKYzFsWFV3ZzllbEExZ0Jl?=
 =?utf-8?B?Rnp6ZWtNWXV4TGMwWHo1dnZQRWE1WU1XWDJOWDNzQ1Jrcmo0elpZTTE4TkVD?=
 =?utf-8?B?VXBMZ2RHT2E2TjFjYXVNZWJaWmpQcE9YRytta1lFVktsalVZaDVMeHltUk9K?=
 =?utf-8?B?NURzV29EYzRTZHN1Z0t0bGxuZm9sV3QraDBKT0twbnhxRFFGeXFNd3k0MThi?=
 =?utf-8?B?cUEwSjRGVVRkMTJmc1ZtUURObk9GVVZiVUZXR2RRcGxVZXNUOWNuVVFQem5i?=
 =?utf-8?B?TkMvS09vYmNNZ09FaEZUVmt5dkZTUjBYOTF2Z2V4VjV0cTQwdFJNblEyU2ov?=
 =?utf-8?B?Rzljc1MwMVNNekJWMU45OFBxc3MxWlpWOS93VGhSS21hOWxKQkZoTCsrVFJC?=
 =?utf-8?B?bnZTRmxUSlJ6dzArdldSaHZUWXQ3U2NINmFiL2ZQOFNYc1I5Mlp4VDJod3U1?=
 =?utf-8?B?MVFTem1OckVEUEVYRWs5VnlOTzVqekFDYjFjWnFvTCtIUmgzeGtBYVkrVUxi?=
 =?utf-8?B?aXhOemdybHJ4VnRlUG9uNjYzbk5IWHBWek0yb1F1OHpCQ0xyY0pEaTVwNUUw?=
 =?utf-8?B?dWttR0dNK1k0aC91cmdXV1NFdGh3dmg2RXVxQjdtUkpnRmFFdUFQano1ckNs?=
 =?utf-8?B?WTBEOFJYT1pZdmdhUmtTakM1WXNnRUpJbGFPSmNTeU5xU1Rzd1FjOUZTMkZE?=
 =?utf-8?B?WmRBNTJaY3Zlcit2VENnbzRSSDVsTXBtWkJOOWtRazFESmpXUnZTNDhocnc5?=
 =?utf-8?B?cEVVMWhDclJweDl6MUszUzVUVFREenpIZHN0ZFczRHI4SlU3TlEvK0FzaXcy?=
 =?utf-8?B?RzBhZlJYa3ROcGlvdDNXUERkSTZROXlGZVZ3SWZ0Q0taUVR5aTV1eU5scEdy?=
 =?utf-8?B?bFlNOFc0WjVzaW5MZGVadmw4T1JDbnRpR2cvOE1IWk9IVkpHU014c1RDKzgy?=
 =?utf-8?B?NkpmSkRXRDhYMjl4RHM0U01YWHJuNUw2c1dnQ29QdS8xSmEzNDBhcjlYaE5j?=
 =?utf-8?B?STUyQzBZQzJXSFNLY0J1cEFqVU9qekYzOCtCVFNXQWdKdFJORXY0dnZRL1c2?=
 =?utf-8?B?SUxtQ1JXM0lqT3Y3UGdFMTl0eU9KYk90dXBvOHI5dnNhRnc4WXNwZzVWaFV3?=
 =?utf-8?B?bENzdDVTdjRLUlJQUHhrWlVORkpMWFRHZ3dic1Y5ZWtMK3ZLU21KQ3Vjbnpa?=
 =?utf-8?B?NXUza0FUV2NYeDZ1eEw1c09BeGdZL1NHdlY1bHMwTWhCWS91RkR1NFo0b0Fv?=
 =?utf-8?B?aVBlVEJZS29FcU0vOE9idnpvTlpRbm9ra2NDT212QmZsV2ZVazA0eFUzakpE?=
 =?utf-8?Q?BGebJebq2Fj9Ln6U=3D?=
X-Exchange-RoutingPolicyChecked:
	rsdtmsG9G9zxyRjWf27Gt9jNgaruI7voGJVEeXfnHAykQVI+kJ/bGpCqwKHU4woMibCGG1YOY+lmi4z2D9aSmNtxVVmh5TbkUNfAShsXZKo8wJUTPNgrAGx2xGK4EZX7cwlmjBaw4soTdWemgXX/QBrr8moei7o+ygvpL0GHvR3Xz9bSEW/MqtXV/y+qoJALIO2pZmKGrlUv4PChMXyLrbJw/CeoLMD/jmqZvBI7f3ufDK5xJtsgoYSOUxRObBosNgRy66n9mNF5A2Ulz8GkwmHq3miDX/7FPWKZTUCFDY4TtKJAXJKJJ9dFk48BBt5k5cb1LQ0CumFVqTcRU8AJiQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0D+3X/8/iVL1Psf6nr28hFjFNNtY6nCg7JIvuKPbF+QPW6GQQjwesx7PbreGmEmDlr8E8/d7tE10Cdhe0WoH6+SBTpuJxh9bTVEDUGV8UT3XEbrRrop/UvuUIAqEIdswUOFe23g2Z8wxD1ztgqn/k/8OO/qO/gy6ekd/xcm5x9ifQ0dBekPVsEHpyjyTFLdxrUcn9N7QCMIX+kOwqkbSzURv1KOkZkSJwkQ6V3WbZ9BZkuGfJf6QJUZOo/eKi12hbzHPFkS6dYeeydk/VcS2PQTk5tcHI1Pmv0o4MVsr89q3bFiotKwSIjwYZvwwRmSCfi06CQVgvtUcrN03tvn1ZVltVTu55vlzRIdhkLB3Ne+IdsRmk9O2fgxo7ws9y/hSMuW5SssPZZ2g+YhS7Bcr3Md7AT5zRYWljG7Rbi9IDTjauf8fKKZPxlMF8NYHKZRQAiRwah6u+gHdnC6q5AMsc0BJA4qRA244lhq+DUnd8skX+Q67u13pk2iOnBNqu/KA+QbPjoltytOqFmdQHe9wU0gWwzt/wUVdMjyOLFVXnOYscRClT5W3V9vvV6yOtLnAWEv6jcpROeRbpUkNBaeF0LXKn/4PSodD3htegWVexLQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910912d6-4431-422c-7fda-08dee96aa35d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 10:02:18.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvFtbS0UudMq5ldCq3V5rrfqkeo+6Z48GXxc4Wpdmd/QGeRLzTe66CxHw5Gjbs0jJfBQmtuDcOhm/mQXKa+o9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607240091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MSBTYWx0ZWRfX4RyLWLBA46E1
 JU8dU7QEEThMTio0ls4RJlfxwcmXOwMldCqQQroONGqlm/637+qM7Nv+BlK9TaDdPeOldAkgqdO
 RaW91J2Q4l8kK6XxzrThlHgy94xz/27pnBOJpyMuLinpXYgMwV3emcj9+ilpW8K6hX8cfGSCzU3
 vpLsmCOPzx+U8SGycN5KIKI2xsV1EfsF0oXur34nbzDjeq8ZhWPEUWNfaIMYw0Z4HvXZc0gbD7C
 zrem3beR4MRs6S+aktqKI1TeHsdZ5d+2FRZ6kgRXyvRaYEno2f32vZydnQTS/TJ0wx57an+X2sA
 X9NEcbmNq1gUQCSNGro5Wcj+z2PNf086NrL+ZDns30mxaE/6KnTAyc6rRszy3olxTYBd9rg9Zra
 4sA1uG6iJ/It08ibLReV9G28Vyw/dBCmaMv5nQpwBwQne/tCsgfGKApj6QVocdx9rFyO5V2Xp6y
 u5V4DZtdACuTNZ97FDg==
X-Proofpoint-GUID: a_YfXd2g5z5J707QwGNHSWgOKbAT2x3p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MSBTYWx0ZWRfX9RILakmP3pje
 nHjOVFpzPZRqNupxwgFoGQWzarGiQkIPdybmNyW411J+4L3Kw34qRwtv32cbtWbANnZCgojc6VE
 pabUSJ23nQBAm49Hg2pDpJsOqSDaKshbYmVwk57o7Mt+D0PpBVNt
X-Authority-Analysis: v=2.4 cv=JrfBas4C c=1 sm=1 tr=0 ts=6a63382e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=69wJf7TsAAAA:8
 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=bV9ps1StvU8TPqs_oekA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: a_YfXd2g5z5J707QwGNHSWgOKbAT2x3p

Ping?

This is a bugfix for QEMU AMD vPMU live migration (and, indeed, any operation
involving saving and loading vPMU registers, such as CPR).

I have confirmed that the patch still applies cleanly to the QEMU master branch
and compiles successfully.

Thank you very much!

Dongli Zhang

On 2026-06-09 7:09 AM, Zhao Liu wrote:
> Cc: qemu-stable@nongnu.org
> 
> On Tue, Mar 24, 2026 at 07:12:36PM -0700, Dongli Zhang wrote:
>> Date: Tue, 24 Mar 2026 19:12:36 -0700
>> From: Dongli Zhang <dongli.zhang@oracle.com>
>> Subject: [PATCH 1/1] target/i386/kvm: Use logical counter index for AMD PMU
>>  getter
>> X-Mailer: git-send-email 2.43.5
>>
>> For Intel PMU, the counter and selector MSR ranges are disjoint. AMD PMU
>> behaves the same way when PerfCore is unavailable.
>>
>> However, once PerfCore is present, AMD PMU switches to an interleaved
>> layout in which selector and counter MSRs share a single alternating range.
>>
>> MSR_F15H_PERF_CTL0 = 0xc0010200
>> MSR_F15H_PERF_CTR0 = 0xc0010201
>> ... ...
>> ... ...
>> MSR_F15H_PERF_CTL5 = 0xc001020a
>> MSR_F15H_PERF_CTR5 = 0xc001020b
>>
>> The commit 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM
>> reset") added the getter/putter pair for AMD PMU MSRs to clear them on
>> reset, but it ignored that, without PerfCore, AMD reuses alternating MSR
>> addresses for selectors and counters. env->msr_gp_counters[] holds the raw
>> counts and env->msr_gp_evtsel[] holds the selectors, so with the
>> interleaved layout we must translate the MSR address back to the logical
>> counter index instead of treating the interleaved slot as the array index.
>>
>> The arrays are sized to MAX_GP_COUNTERS = 18, so the code never writes past
>> the end. And in the reset path QEMU simply zeroes everything, so that use
>> case still works.
>>
>> However, the live migration is broken. The PMU state is stored at the
>> wrong indices, so the destination VM reloads mismatched selector/counter
>> pairs. Fix the getter to use the logical counter index rather than the raw
>> interleaved offset.
>>
>> Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM reset")
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  target/i386/kvm/kvm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Sorry for late response, LGTM,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 

