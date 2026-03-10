Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F62399343;
	Tue, 10 Mar 2026 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182022; cv=fail; b=idqAaai7PUrL9aMGsYwHa9yxQo/SVD8eDXhsYFbBIzNHyz131/2XpdUF/NjFc5FzlvAFYgF3lBKxO9qTuHdI2A4/9TGKdI6p+ei416yULZyKMdyetl+RbtNS0LRaoD9ec0M7sLKpMMZGeAgXF6FHwqzZpCWAiB8tCE2cmVjB5HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182022; c=relaxed/simple;
	bh=k0SPQZCuT74Kx60Ic2+TEQfhj9k33ec9ihiN6nScQKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DIGXBzSB3d/CiU79qaa/JbfR5edzpqhK6fdnOmkZ8Vv9DxPbdiwrt/XsUkb6pCsKof5XN6il7UjrX7zgKH5BQRfZJRyHA6vJwD7HMGzObnqndFfJMRM4bq+5yw3NJJZ331vB0Qr6qbYN1yd0RzthzYoblEoDQg1ejV9CQXCdUBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QfEZAY5I; arc=fail smtp.client-ip=52.101.43.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QfEZAY5I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6FbcRjGsvTTYnH6WB7y/a6grCQfXvwXVZn1OdL/t0nWZ+CTkrZK98P/0xWys6dNfbqIlrLcIwsKGNdWCJFCy+P3n5ac4KFGLDkkWSlCR5S5iqtqOy0p4668XOv1Qmiy6GNkip76LegA/rMLzSegiJFHwxyraSBLmyjKvmZ+zLkkufGte1DjAnJ6+DuHvB7bMcpCG4wRQWMLy4FXbaRB+5lyfPUPuM8axtFZHXjEyPBgKsbQLl1di4fPQk6OsTxAZsI/+/RaVUXH6Nju4iOl74eRsRKwhfyOAIF77oXrDeXpe9RkTXeq27k2Fl538XqDwTnVXOpz/LHG+5ObMObBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/ysLTyk5wCt13jLh81yglI89kZy174NWzEicwQ591s=;
 b=zKqbzZHZ3Uw0HNxVgoUzgLfCAyjGan/dAitBkc1EMpKOSlxirzjj1bnBF8NUdfbBR0jDrHWF+KBIJJY9dYRLKd+3nH3NhqpTCJtjjLRkvTBMBs9yPzwOyVXAM7wSGZa8sQxl8LclWsTg16eThDuNrxAEbu3XVYKiH7U2M1XRemd7VViYavTn6XFfqk4+wT3eeMlmMWBXfhJY+8bQqeEhp1ohBvhN2XWA44lk/t3WZpPFGuAr/spRQXsHVOxZEP3U08eFHd6VjjSONg/zu0VCoKw6y5So4Y/9UBr1DSM5j2Y8tSDJR7ufeagXwzp/h07duK+dlMY4WwLpRiujyjSH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/ysLTyk5wCt13jLh81yglI89kZy174NWzEicwQ591s=;
 b=QfEZAY5IcN5J748OdiwetraAgQCV908LsJaoBjl26jla0fghMB/4xXzuFqfpyfSzmIvEEA42TJI+zItmDxhAqBduPUMVA4mhiW/rVIuNxM26yZOOsuD2FjA0Sn1ON2MloG3NfLXdsummvbGG1z2eLWwaNpK3LYtx/n+LpFrLSto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BN7PPF915F74166.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 22:33:39 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 22:33:39 +0000
Message-ID: <dc6809fb-ef44-4fce-b98a-bd80edf7d64e@amd.com>
Date: Tue, 10 Mar 2026 17:33:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
To: Sean Christopherson <seanjc@google.com>
Cc: Naveen N Rao <naveen@kernel.org>, Srikanth Aithal <sraithal@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
References: <20260203190711.458413-1-seanjc@google.com>
 <20260203190711.458413-3-seanjc@google.com>
 <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com> <abBSPkKmMiFCfKek@google.com>
 <947bf241-d149-4933-874a-de96aeb73dff@amd.com>
 <abBYiODdL4405KbB@blrnaveerao1>
 <debf1c3f-f0aa-4b9d-ba35-feed87aa899e@amd.com> <abBkgY9W4_PD1uef@google.com>
 <23ec6b06-96b9-42aa-937a-908b2ce73a69@amd.com> <abCT69PvxOo9ERu2@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 xsFNBFaNZYkBEADxg5OW/ajpUG7zgnUQPsMqWPjeAxtu4YH3lCUjWWcbUgc2qDGAijsLTFv1
 kEbaJdblwYs28z3chM7QkfCGMSM29JWR1fSwPH18WyAA84YtxfPD8bfb1Exwo0CRw1RLRScn
 6aJhsZJFLKyVeaPO1eequEsFQurRhLyAfgaH9iazmOVZZmxsGiNRJkQv4YnM2rZYi+4vWnxN
 1ebHf4S1puN0xzQsULhG3rUyV2uIsqBFtlxZ8/r9MwOJ2mvyTXHzHdJBViOalZAUo7VFt3Fb
 aNkR5OR65eTL0ViQiRgFfPDBgkFCSlaxZvc7qSOcrhol160bK87qn0SbYLfplwiXZY/b/+ez
 0zBtIt+uhZJ38HnOLWdda/8kuLX3qhGL5aNz1AeqcE5TW4D8v9ndYeAXFhQI7kbOhr0ruUpA
 udREH98EmVJsADuq0RBcIEkojnme4wVDoFt1EG93YOnqMuif76YGEl3iv9tYcESEeLNruDN6
 LDbE8blkR3151tdg8IkgREJ+dK+q0p9UsGfdd+H7pni6Jjcxz8mjKCx6wAuzvArA0Ciq+Scg
 hfIgoiYQegZjh2vF2lCUzWWatXJoy7IzeAB5LDl/E9vz72cVD8CwQZoEx4PCsHslVpW6A/6U
 NRAz6ShU77jkoYoI4hoGC7qZcwy84mmJqRygFnb8dOjHI1KxqQARAQABzSZUb20gTGVuZGFj
 a3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPsLBmQQTAQoAQwIbIwcLCQgHAwIBBhUIAgkK
 CwQWAgMBAh4BAheAAhkBFiEE3Vil58OMFCw3iBv13v+a5E8wTVMFAmkbaKgFCRZQah8ACgkQ
 3v+a5E8wTVPFyg//UYANiuHfxxJET8D6p/vIV0xYcf1SXCG78M+5amqcE/4cCIJWyAT3A1nP
 zwyQIaIjUlGsXQtNgC1uVteCnMNJCjVQm0nLlJ9IVtXxzRg0QKjuSdZxuL5jrIon4xW9hTJR
 94i2v3Fx5UWyP2TB6qZOcB0jgh0l01GHF9/DVJbmQlpvQB4Z1uNv09Q7En6EXi28TSv0Ffd1
 p8vKqxwz7CMeAeZpn5i7s1QE/mQtdkyAmhuGD12tNbWzFamrDD1Kq3Em4TIFko0+k5+oQAAf
 JFaZc1c0D4GtXwvv4y+ssI0eZuOBXapUHeNNVf3JGuF6ZPLNPAe5gMQrmsJinEArVYRQCuDA
 BZakbKw9YJpGhnSVeCl2zSHcVgXuDs4J2ONxdsGynYv5cjPb4XTYPaE1CZH7Vy1tqma8eErG
 rcCyP1seloaC1UQcp8UDAyEaBjh3EqvTvgl+SppHz3im0gPJgR9km95BA8iGx9zqDuceATBc
 +A007+XxdFIsifMGlus0DKPmNAJaLkEEUMedBBxH3bwQ+z8tmWHisCZQJpUeGkwttD1LK/xn
 KRnu8AQpSJBB2oKAX1VtLRn8zLQdGmshxvsLUkKdrNE6NddhhfULqufNBqul0rrHGDdKdTLr
 cK5o2dsf9WlC4dHU2PiXP7RCjs1E5Ke0ycShDbDY5Zeep/yhNWLOwU0EVo1liQEQAL7ybY01
 hvEg6pOh2G1Q+/ZWmyii8xhQ0sPjvEXWb5MWvIh7RxD9V5Zv144EtbIABtR0Tws7xDObe7bb
 r9nlSxZPur+JDsFmtywgkd778G0nDt3i7szqzcQPOcR03U7XPDTBJXDpNwVV+L8xvx5gsr2I
 bhiBQd9iX8kap5k3I6wfBSZm1ZgWGQb2mbiuqODPzfzNdKr/MCtxWEsWOAf/ClFcyr+c/Eh2
 +gXgC5Keh2ZIb/xO+1CrTC3Sg9l9Hs5DG3CplCbVKWmaL1y7mdCiSt2b/dXE0K1nJR9ZyRGO
 lfwZw1aFPHT+Ay5p6rZGzadvu7ypBoTwp62R1o456js7CyIg81O61ojiDXLUGxZN/BEYNDC9
 n9q1PyfMrD42LtvOP6ZRtBeSPEH5G/5pIt4FVit0Y4wTrpG7mjBM06kHd6V+pflB8GRxTq5M
 7mzLFjILUl9/BJjzYBzesspbeoT/G7e5JqbiLWXFYOeg6XJ/iOCMLdd9RL46JXYJsBZnjZD8
 Rn6KVO7pqs5J9K/nJDVyCdf8JnYD5Rq6OOmgP/zDnbSUSOZWrHQWQ8v3Ef665jpoXNq+Zyob
 pfbeihuWfBhprWUk0P/m+cnR2qeE4yXYl4qCcWAkRyGRu2zgIwXAOXCHTqy9TW10LGq1+04+
 LmJHwpAABSLtr7Jgh4erWXi9mFoRABEBAAHCwXwEGAEKACYCGwwWIQTdWKXnw4wULDeIG/Xe
 /5rkTzBNUwUCaRto5wUJFlBqXgAKCRDe/5rkTzBNUw4/EAClG106SeHXiJ+ka6aeHysDNVgZ
 8pUbB2f8dWI7kzD5AZ5kLENnsi1MzJRYBwtg/vVVorZh6tavUwcIvsao+TnV57gXAWr6sKIc
 xyipxRVEXmHts22I6vL1DirLAoOLAwWilkM+JzbVE3MMvC+cCVnMzzchrMYDTqn1mjCCwiIe
 u5oop+K/RgeHYPsraumyA9/kj8iazrLM+lORukCNM7+wlRClcY8TGX+VllANym9B6FMxsJ5z
 Q7JeeXIgyGlcBRME+m3g40HfIl+zM674gjv2Lk+KjS759KlX27mQfgnAPX4tnjLcmpSQJ77I
 Qg+Azi/Qloiw7L/WsmxEO5ureFgGIYDQQUeM1Qnk76K5Z3Nm8MLHtjw3Q7kXHrbYn7tfWh4B
 7w5Lwh6NoF88AGpUrosARVvIAd93oo0B9p40Or4c5Jao1qqsmmCCD0dl7WTJCboYTa2OWd99
 oxS7ujw2t1WMPD0cmriyeaFZnT5cjGbhkA+uQGuT0dMQJdLqW3HRwWxyiGU/jZUFjHGFmUrj
 qFAgP+x+ODm6/SYn0LE0VLbYuEGfyx5XcdNnSvww1NLUxSvuShcJMII0bSgP3+KJtFqrUx9z
 l+/NCGvn/wMy6NpYUpRSOmsqVv0N71LbtXnHRrJ42LzWiRW2I5IWsb1TfdMAyVToHPNaEb0i
 WiyqywZI5g==
In-Reply-To: <abCT69PvxOo9ERu2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:806:23::15) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f31010-b289-4b37-41be-08de7ef51308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CRgsO6krzowZUwf6rmJUrb4vy6C+8ucX9xdhDpo1Ha7DQ1faIQLfUNPR5J17pLSQHEdgL6oFDDsr8Gc3CtVuutFTXmWF/glRBst0xZVmFTeDKPAYgOsPAikGjpZGuQd+3eifL6xTzn48oNBFZhpfOPNEatFbQxgd/R/w47FJ4vL7RgFdqWjGi/hbMyoxgbUvFBdUFEqKvU/lcdsruFBHygWkMMAay/UTe5f8wn/qCdJ73pQ6HZjBSd/IFyLLeFY1Mp6WmQNvDThI4pOnsEb7uapBaW88m3YC8PMK9h7wxotj5Eef6jYeqNpeZLpQ8AXPwj/+cvKPjj9ZZSy/euw6/+pPQPoMLq3ku5vvHqwCvXzg00S80ddlxuA5cr6qPomhlY162HgcT9icnNueraCk34dIk+28UM+NlMye//5zN8X3nqgpMLDUyfKd1Hr+ZxtnEpfSLsCmoyhocn7aesaW8O1Rue/WoO971mD00Ri5K7IevDfvZNRB8uMhO2o76X8voyXap8Ls0C//QHuSEziaesKf43Njyk05Altdh+0yazrgnuaJwfWL22bfdtXfpZGcySmxEx8x/fhV+KFQMfSQNYL1H71xm/Rjubo1xXkEaXZQYPOnx7YPEdbGFmZ7S+z65bW8K9tcy9wR7Jr7GU2QDqyERikQfvFTSW0bkcDuZ54U49qhHgVY9hd3t3xQ4unMY5/E5HbkkherU2g7+3O+U78DqoMpscWYZ1EoB8gA/js=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlI1aDd3QjlCWjcvTmcwVjg3aWJpeGZpU2dCMU5tSlczOG1nQmh5SXF2aHd0?=
 =?utf-8?B?d25mcXVoL0M3ZTA3YktFd1NEUjVnQ1ZnZ2pGV1hRdExMcGNTdU1jdTV4NnRC?=
 =?utf-8?B?N1FxOHU0OWxHSlJIcUczK0xuOFcvVGthZ2ZHcDZYNDlSV283NTdpSjRHYkRp?=
 =?utf-8?B?bGtHTHdsOXlpUkVrMTNmVGF0QVQ0cU1vdGI0RktGOWJ1RFFJRWdqQWhpR3R6?=
 =?utf-8?B?MWRxaHA4OVVyOG9QaVZ0dTZDcjJWNURZNFQ4SnIzdVBuMVRHVHVZUGFrK0R5?=
 =?utf-8?B?ZXAvVGZKTkwrclpxTCtMN3JTLytGcldYNVFTQTVJdTc3K1F4WWg0M1RzUXBu?=
 =?utf-8?B?YWsyL05zMlVCWUhpdTArNUM0d282UHAxa0loSWdEeHM5eDA1c2diZ2F1Qmk3?=
 =?utf-8?B?ektWTi81SVFIOXBYSW9QMXI1ODVidmtMNmJ6WHJtbGZHMmVKeVhnSm01UW9p?=
 =?utf-8?B?angvdHFZL3pFTytPaFpZME5qVzcrMkVhaDR0UDVTbmI0R1I2ME14ZjhqT2JK?=
 =?utf-8?B?VTJtS2ZaYmtvWDl5TE0xdjkrZXpTcmwwQ25ONlQrdWdjU051LytvWkJ5c1lE?=
 =?utf-8?B?KzlnUlNLMjVUdHM5S1NCQkpSSXV6Um1QTWNnYTVFQ0dPS0RqS0poNXowSyt0?=
 =?utf-8?B?S1hnb21FTTFpSEdmTUhHbGlJUVI0RHZlV05oL2o2WCs4MVJwV2UybksvRjcv?=
 =?utf-8?B?ZklhaFhPWjBib1E5K0RURTVONlhKL2UzL1ZiQXBwU3h4OFVEUHdReU1Ya09z?=
 =?utf-8?B?SWdKNzVYUW90d09OaWNiYmxvdlBza1cwYXE4U0M1MkJ6Ymk1eE5CKy9tTTBW?=
 =?utf-8?B?Zm5qTy95RVpZZkp2QUNBbW4rT1NRTzlyaUQyVkRZVDNFN0IyRVlLQU5oNXZn?=
 =?utf-8?B?VjV6T1VLZnRMVUw0dlJjZTNQOGNVc1ZQU3JqdTJvcHlCR0xUSFIyOUlzTGcv?=
 =?utf-8?B?OGE0NzJzamlQVWhNdTdZSDd3dVplSFdROVpuZmZQN1c2bllRZjBncFpwbXY5?=
 =?utf-8?B?OUkrdFZJK1RRT3pnelZlZ1ZkOEJ2aHo3ZXYvQk1JbER2RVEvdWtuMWo3TnJH?=
 =?utf-8?B?L21HeTJZaVdrbUtmMWZUR1hmdzRMQWQvT3lua0N5SEpWZTNKRmtXM1cxekVI?=
 =?utf-8?B?d0ljN2QvSFFoTDhrRVFhaU50U3p2QjNVaURxZWVaQ3E3MVZValFZcTU0WXpD?=
 =?utf-8?B?ck82R1FQYlh2Y1J6b3VPdW45c2N4TVUwUzJuRXhmcFBQYW4xOEdOVlZOYk43?=
 =?utf-8?B?ZTJDbXlBUSs4dFBxQmFCSE5wTC91amM0ejAwZXpiVGhrWXVqN2NnN3RjTm5s?=
 =?utf-8?B?K1RCM2crM2xLRWVCVnZRUWJrcTFrQnIxdkpGUmlKYWpjVXd0YjUrc3J1endl?=
 =?utf-8?B?WjNOc1Z1Zmo3amMvdHI5VlJHdVBsNkZYRUZyWm1zaXUrQmtCU0dZSjlOUjBX?=
 =?utf-8?B?ZjdvNGczc0hON2xBZ2NhYnpaNXB4RHVLL1dJMzdwTXBKWUdUaldVcnk2YjBQ?=
 =?utf-8?B?QWxtdkVyOVZLTnBNOXRqajBRbkRweTRlZndLQ0JsTWpBdDlBWUh1MEljY2tN?=
 =?utf-8?B?MzhDd2pwUGtOTFQxd2tDSUphRW5OZTc0VUZ2UXRkSGp1MUZwVHBBaVhiVEFX?=
 =?utf-8?B?WHRTc0lVS24yNFpDb2M2REFDL2VQZzNETnlwUFp4R2xtcU1QS21qSVR0bFRr?=
 =?utf-8?B?M0Zvd0VrZGVwUWhlcHoxeElaZis3YmI0Y0owbVlIVStVM0J2eStSNU1ZdU93?=
 =?utf-8?B?SjFOVEtiSkY5cGgrV2NvZnM2a2pjUDkya25mNEFjeDlQanBZVXFPOCtuQ3d1?=
 =?utf-8?B?T2wweTJoODNnMkJmN001UGFhMTkwYmJPUGlrUUg5Z1JqNXh6Y0VTdnhvZDln?=
 =?utf-8?B?TS9HVkkwQmNoKzdHcHdpS2F5MGQ2a21yWkNPUlpjamZ0TitLemZDd01lR2FR?=
 =?utf-8?B?TTZ3YzRCbERDa1FUUEw1S0pXWVk5eCs1L3pLNk11UUlwRGJsMkU4VHpRdG9J?=
 =?utf-8?B?WmJhY1FvdEcycE1NYlQrdGdJU2JCdlBnTS9ITXQySy9FS3F6S3hFSEZjQjlm?=
 =?utf-8?B?dHg1clJZSG5kUTJuNTliUmYrQ2V6SFNVNWVzaHRJNCtnK1NPRk5pL3NXR0wx?=
 =?utf-8?B?SzI2UjJPdjdwL2VwczFRd3hXSUNCYXpwSDRUMkVXaUNaZy9ScEtpT3hoS2o0?=
 =?utf-8?B?bXF6eWlVcEplUExzRi9GMWJmMGF3SEJJR2h6YmRVSTNnY3dHekM5bW12YUkv?=
 =?utf-8?B?T0lIV1RkMWNVazR1OHUvWkdRby94L1FaQkJxSEVYeWxvZXlVWmlkYkNPZFBr?=
 =?utf-8?Q?AsCltm6d4tbpuJVstt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f31010-b289-4b37-41be-08de7ef51308
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 22:33:38.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIOIiDzkzlBrHnGalBxSi2KApLIOMDm5Ewj4k9wSatdP5Kg36DBq9sh5qw5n9jpdOq36p2T16MgdAH7O+EaZ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166

On 3/10/26 16:58, Sean Christopherson wrote:
> On Tue, Mar 10, 2026, Tom Lendacky wrote:
>> On 3/10/26 13:35, Sean Christopherson wrote:
>>> On Tue, Mar 10, 2026, Tom Lendacky wrote:
>>>> I'm just saying that the unconditional trap for CR8_WRITE isn't flawed
>>>> for SEV-ES+ because AVIC can't work with SEV, so there isn't any time
>>>> that CR8 writes shouldn't be trapped.
>>>
>>> Yeah, I forgot that (obviously).
>>>
>>> But sync_cr8_to_lapic() is very broken, no?  INTERCEPT_CR8_WRITE will never be
>>> set, and svm->vmcb->control.int_ctl will become stale as soon as the VMSA is
>>> live, and so in all likelihood KVM is crushing CR8 to zero for SEV-ES guests.
>>
>> I don't think so. V_TPR is written on #VMEXIT even for SEV-ES+ guests,
>> and since it is a trap, CR8 is set and so V_TPR should have that value.
>> That would imply sync_cr8_to_lapic() should do the right thing.
> 
> But isn't svm->vmcb->control.int_ctl stale?  Oh.  "control", not "save".  /facepalm
> 
> Ah, and I assume Secure AVIC hides vTPR from the host?  Or at least prevents the
> host from setting it?

Secure AVIC will prevent the host from setting it since the backing page
lives in guest memory and is encrypted/private.

> 
>> After attempting to verify this behavior it turns out that writes to CR8
>> (and CR2) are, in fact, not trapped, but the APM was not updated with
>> this information (I'll send a patch to remove that code). KVM's CR8
>> value is, however, synced with the proper value through
>> sync_cr8_to_lapic() because V_TPR in the VMCB is updated on #VMEXIT.
> 
> Oh.  Huh.  So doesn't that mean that supporting Windows (or any other guest that
> uses TPR to mask interrupts) as an SEV-ES guest is practically impossible?  Because
> while KVM can observe and manipulate guest CR8, KVM won't be able to precisely
> detect when TPR drops below a pending IRQ.

Could we do something with virtual interrupt support? Today KVM uses the
virtual interrupt control to detect when an IRQ window opens. We could
do something similar by setting up the virtual interrupt priority,
V_INTR_PRIO, at the level of the current TPR/CR8 level. When the TPR
drops, that would trigger a #VMEXIT and allow the pending IRQ to be
injected. Thoughts?

Thanks,
Tom

> 

