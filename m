Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DC32C302;
	Tue, 16 Jun 2026 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647932; cv=fail; b=h1GkjQhrDvuW5qgkYJgjrirqLgd0ZxI00oy/DRRaeRawXAG8D0QenG49CPdxKoKXu23Mig2+UetZgKlTKY+QZe4EoEl1W792qHHrArjMq6eIm9TGJ7C+M7WXbNVQnCACVafv/efaVzU0tC8ynLas4kO1+l7OO87Ek25Fb1MkwVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647932; c=relaxed/simple;
	bh=4mTjBQACv2avp64yWv8zCrn4tqg9gpE28uMd5jP/F1Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FMgbyA3W5krFt+hTnhAhaIuaFgauyktKdPXKXyZLaLop3P+0sMvdKN1r2ZLw5xX6GIqOXoP32FLJKTb+nNLsViptxSI1RL0xvB0GbtjqxC1X+UF598mWUt86BoluYziplaaHONcCzDyf4MA1f+wqO8A0AIDIsoQ42KGrcXEVY/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DONaMwxF; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DONaMwxF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyUiB5cPZ721Go4MRwWbUM1UOfPC4C7p8u5PIl+3WE9LTMvxL69POzyEz0JONsNWGYRGFRWvmUc/CzyT0iRjCwAA2opx7BUlEmTv1G0BlEIEB7VhAqhVNG1MwuABPLn8i57TvwVmezpWxRUNIK4q4Pabnw1GKxys4RKNQnaczApPq1seH3MaSVPd9eF9pBgU4CzOLktinUOkh8s6qkS3x0O+DQv++FKLVU0YXFxNrZKlE0Y/IncFicgOPcC1SNr/iMO/MlVpA2x8q5zS119BLaHsMtmas3pIiFr2wbTYQpxn4nNZitFb0QM0/7DKhdTQGo4G2TXvB1Nw2OAnFE54RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK9r43MN8YXdT1/mBqz14IIPuZs4/L2iYOPABDwat6I=;
 b=fdauFd4jvrgE83wKCv5XehjrVPiuoQk/YVF8EGm+ZBwXQX+/UDh5Fb9bYIsmlvAf4bWIuzHCEKEbaQdEVCFKScINjTu5buiLhnJsi3Vrm6+3tZowo3du8IyKolRd04CJYT2tFuhWCAkLzMTDCNbwRxb9CzV9xUY/tihj3Xw6Y9toMSQOJZEwoup/lm3H6IwsPSt+BvTknnK+tmZIyBGcpJo8spIQuj8/yJDcJyqfr68bkRD/0uwguxJzWsn8X5TxJdT5EZSvy0bMshlARUqQxEUB1CmeMO4xH5B6PCe7fEB6LXb0Cy7caBumBoFKypknepwoejEWh0EEbVx2gzkN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK9r43MN8YXdT1/mBqz14IIPuZs4/L2iYOPABDwat6I=;
 b=DONaMwxFKPEknRUne1H9XuI1LGucNod7BykcxQ6RQZaQRPuKF2XkKDls2J+n/uK9i7Oa2GVOHBOsI4nnCKqwUngrkbMeJv3fP88CGzImT+8cA3Jx60jMotzUZLa5/9r8pY3BwE1mwO8nCcrVmnHYciBLAuTIElPZJvkXONVzUhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 22:12:01 +0000
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2]) by SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 22:12:01 +0000
Message-ID: <ffd2a573-0287-4801-8963-f49761e70e28@amd.com>
Date: Tue, 16 Jun 2026 17:11:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev,
 Joerg Roedel <joerg.roedel@amd.com>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-5-joro@8bytes.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
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
In-Reply-To: <20260611123528.572255-5-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0122.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::24) To SJ2PR12MB8136.namprd12.prod.outlook.com
 (2603:10b6:a03:4f8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8136:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd84a58-bb81-4775-4c9b-08decbf44a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	uITUYvrns8f2LbdbRlmhC77hoM97mkhcaIKdm7NkXD1F8f+ZgwcKvC1iZ7vyzvtauhZgL/KVeEn08IQ8gd0alkdVBW/hi8doRhUDQBKz6T5S1A9PeNAhuAmBQ2Mc/l5D6HsXlKhL4vD38EA/IZtioWbeKMCabbFpSo+k5Ysux9WrM7xqQIF7gxG1KcDXf1NGzdcW+DPlQVtq4Po1xzVicCA8pmQ6pCbtnc/ARqjQpNNr7/HRdyatNuI/R/IKVFvsBhAwaP5oLmPljWzFOKv7WxxQo9t04qL9ruVOtV6WVEBqrbxdhEQJ90aL0aZoYJKlppA7RGOZH9tY29HZNCiMnut6yAFB3pTf0Sy+cw6o8MUBETW/fcjVtp89fRhi+pfFhi2zdyzuNCU+j21ynGykneRRpRLG67fnh9PoX49yBdD3NYwC3gsXcuCqRqM/jZSXOyFAqvZWNljD6Zo+E5juZwGlf6nmIzdnJN43sPMA44KNDz4jDvwfzvYXSC6/U+lB+Ldy5RtqxU8RfsuCgT4zk1z/9IiD9qpUBXgHWdaJT/EN0bFMouselcWvxRmrC4QHntL8tjOLDKsUQKaxP/rSHQT25uLcOdPcc/t3T8TgrUk4jHPeZY2PTX+qJy/0q6k+F/tIHYtEydTx5qD0VIJMy+zufRYed2HUQwax3+YyDorQeJS3x4yJS6iLYGNhcVZy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWJyeW4vMEc0aTR1YkNJbDlHbEVBYytuZG93ZUhEajlLZHY4T0NYdlB1TXJM?=
 =?utf-8?B?MjRVMEhjc2N1VTRvNTFYN000YjZkSFhGd0J3Vk1DcHNzejJvMmozaHBabW5F?=
 =?utf-8?B?VTFXcnZER05OZkdZOW8zNzVUUmg4emJoZHJRNVNwRlpJMHAyTVdBZkV5L3I3?=
 =?utf-8?B?eVRqV0hSQkJTRGR3bmI3N0syb3JCSzVBR2Y1TVQvNEZkTXJna2dLQjJ5U2RT?=
 =?utf-8?B?cmlyNk5idWlva3RGVzFmWXBSRmIyMHRSRHNPLzV4dktMaDlzeEQ3UG1iaUMx?=
 =?utf-8?B?RzlwTHkrVUROTER5bndQYklXbUpEbnZMSWo3c2RoZHZVbDRaaU9uYlo4a1FR?=
 =?utf-8?B?K005cG96M3grT0xDUkllVkhiaURseUF6R2E0a0JBNmxWblc4azJCSmdCbEVq?=
 =?utf-8?B?dkF2RXpKNkZ6Qk96Sm9vdlNwYjh6WDRUbzVIZVVaS2ZWYkNWMVNFQSs5NmZi?=
 =?utf-8?B?cWs3NXBvZU1hTG1CbzZ0M1luaVZPWmdxSENzeGRUWTc4RDZhOU5RMHc1Rko3?=
 =?utf-8?B?NE9JNnV4Y0hHOWExT0dsVzJMZ3hKWHAvdHhiaHdnQk1FOEk4OHA1ck5RcG03?=
 =?utf-8?B?SXJjMXZnTWxpenNOd3pib0FVVVl6R2pMT0RhVkJHT2cxUVQ2cC92UDJ5eHBr?=
 =?utf-8?B?TUI1TUhRZ3VVam5ab0hjTmFSUXQwVFRaZVUweHRtalpiUjYzQkZNbFN1N0tm?=
 =?utf-8?B?STVobjNrU2hCb3VYekM5YlVFVGtJbHlRSU9yNGdmdi9JMVBRVEhudVlwV1Zh?=
 =?utf-8?B?VmxGRnExcmUvbE9IZ3FkVzdPdmhFZEpyVUU0R2xwUWdNYkh1aFFoNUltT0ZJ?=
 =?utf-8?B?Q1p2THptTXhLdWwxZmhHaVhLWjJGVm5CLzlmemlBa1hMR1JnNHl4aTJrRk5J?=
 =?utf-8?B?OHJON1JPcGcrd1ljWGR2bDN3Z3B4bXhKMHZmaWp4bUJhdGd3ODJtZlI0SThF?=
 =?utf-8?B?K0dYTzVaVnE0by9ObERYTS9sYnBaRTY0NExnQUJTZlhzbkJzaFFyaDk1QzJX?=
 =?utf-8?B?WXQzd3BFQ1JrczN0bWdLSFAxNithR3lWaUpYVysrYW0yMWd1VEhLdDRyODhi?=
 =?utf-8?B?SlZ3ZTJuZHByS04zWm5NZTBhSW9PU0l1L2dzWmVFWjFVWEhPTTBvaWtETlls?=
 =?utf-8?B?cDJuSzBhdlE1ZFN6RkgxL3NTbnVSYS9ZQkEvYm51dlR1b05VNEJwODhSTnUx?=
 =?utf-8?B?b3p6N1FrZk8yVzhCQm44RGVWVTc1Q3hvQytPZ2xZdWgwMUxpMmw5ZGxMZ1ZO?=
 =?utf-8?B?RFBJOFV5VGRBVmZKQ2ZUV0pzVy9jdzNock96d3lwS3l2azZ5SWczZTJUczc4?=
 =?utf-8?B?R1FCY1dtRm51aU5EQ1lSYnU2Z3NRbU8xRll0L2FOcWxjZVlpTGMveXpiT2k5?=
 =?utf-8?B?TytUK0ZwQXllVTJQaDRITk0xM0RGbmY3RHJQNWNwUzNjUjQzYXY0NlhDb1N2?=
 =?utf-8?B?aFI4cGRGNGhsVlU5YzdIeDN2UEFIcDF6QWZLWkVXNXBZR0VjK3VMdHJVODNi?=
 =?utf-8?B?NVJFWGswUjd6RUcyb1poUS9tR2tZeUV0RFdVRkF2amRrbkJHcHhlYjlFVUhk?=
 =?utf-8?B?cjVReHAxbWFCdDc4UGlpcGY4NFRrMjNlQW9rNzc5NTFkZEZEWG54Y3ZVQ3dN?=
 =?utf-8?B?UUhOcHk5alZLcXoyTUJWdTM1NG53TWdHWThnekJ4SXNRT2x2aTFFWFkvNGd2?=
 =?utf-8?B?WUpqU2JERmlUUjhDa3FhVWZKcUFCNFBNelFmWUd2V2lYSC9aQmVTTmlHd3Uy?=
 =?utf-8?B?ekRNQzRsODZUWmhUdFlPYit0bGFtMUpkZlgxWTZkY1c5ZGhpajV3U0I1Nk1H?=
 =?utf-8?B?aXE0eEpEWFREOW4vbkQ5TFc1Z21NcmZ0MkZGcm41U0FKaU5mcTBhajNoaVBX?=
 =?utf-8?B?eEVEcjlPZGhWQnRmc3p6cEFTZTlyb0laUGhCRHN4bFc0VnoxYTdkNW9NSU9x?=
 =?utf-8?B?QmJnYmV5bnJ2RVdqUGNFYUVTRkliQzlsZEZNZmRwNGJVaW5UWENFUEQ3akRl?=
 =?utf-8?B?Rk9IanRxWVZQTEtVVUQwanlHK0ZhMXF4MTladTB6cE90M3lZbHhOYkt4YlVZ?=
 =?utf-8?B?ZGx3QnRGa1lSZE0yb2dVSDlLeTlDNUdES0F2MTZEVXFROFVsSEplZDhha0Jt?=
 =?utf-8?B?OWNBLzNva1lUcUtHa2xPcFFDcFFEWGdRLzFlbGdVVFp3dmsxeWFKSnpLNmZQ?=
 =?utf-8?B?WjAvb05SSkRyMnJTbzlHU1NUbUNVZkdMZ1VPVWMybnZFa0xkNUZwWXVWYXo4?=
 =?utf-8?B?M0RqQVFVVXJhMlQvYUFtYklvVDIzSzllWmk0R2VNWFJDdjVuRzU5UTAwSW9t?=
 =?utf-8?Q?G4UHAqhBkYEfeyGPNt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd84a58-bb81-4775-4c9b-08decbf44a5b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 22:12:01.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WymEhP/WqbyuYBKCk2hOYuR8hjgZ5ZkwdpQ1MvJx9larg33Ul6+FGMcdwYBlqPgee22FMR5nKqYtritzUGyYew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154

On 6/11/26 07:35, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Support setting a VMSA in guest physical memory during the SEV-SNP
> launch process. Only one VMSA can be provided which will then be used
> for the BSP. All of the APs will not have a VMSA allocated or assigned
> when this feature is used.
> 
> This ensures stable launch measurements on SEV-SNP which are
> independent of the number of VCPUs the VM is launched with.
> 
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  arch/x86/include/uapi/asm/kvm.h |  1 +
>  arch/x86/kvm/svm/sev.c          | 44 ++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/x86.c              |  1 +
>  include/uapi/linux/kvm.h        |  1 +
>  4 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 5f2b30d0405c..fc87a5ba295b 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -885,6 +885,7 @@ struct kvm_sev_snp_launch_start {
>  /* Kept in sync with firmware values for simplicity. */
>  #define KVM_SEV_PAGE_TYPE_INVALID		0x0
>  #define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
> +#define KVM_SEV_SNP_PAGE_TYPE_VMSA		0x2
>  #define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
>  #define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
>  #define KVM_SEV_SNP_PAGE_TYPE_SECRETS		0x5
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 88db83b3ff8e..90399d5d0358 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2520,6 +2520,20 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	return rc;
>  }
>  
> +static bool snp_check_launch_vmsa(struct kvm_sev_info *sev,
> +				  struct sev_es_save_area *vmsa)
> +{
> +	/* VMSA sev_features must match VMs vmsa_features */
> +	if (vmsa->sev_features != sev->vmsa_features)
> +		return false;
> +
> +	/* Must always boot from VMPL0 */
> +	if (vmsa->vmpl != 0)
> +		return false;
> +
> +	return true;
> +}
> +
>  struct sev_gmem_populate_args {
>  	__u8 type;
>  	int sev_fd;
> @@ -2532,7 +2546,9 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  	struct sev_gmem_populate_args *sev_populate_args = opaque;
>  	struct sev_data_snp_launch_update fw_args = {0};
>  	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
> +	gpa_t gpa = gfn << PAGE_SHIFT;
>  	bool assigned = false;
> +	u64 sev_features = 0;
>  	int level;
>  	int ret;
>  
> @@ -2550,14 +2566,27 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  	if (src_page) {
>  		void *src_vaddr = kmap_local_page(src_page);
>  		void *dst_vaddr = kmap_local_pfn(pfn);
> +		struct sev_es_save_area *vmsa = dst_vaddr;
> +		bool accept_page = true;
>  
>  		memcpy(dst_vaddr, src_vaddr, PAGE_SIZE);
>  
> +		if (sev_populate_args->type == KVM_SEV_SNP_PAGE_TYPE_VMSA) {
> +			accept_page = snp_check_launch_vmsa(sev, vmsa);
> +			if (accept_page)
> +				sev_features = vmsa->sev_features;
> +		}

I don't think there is a race here given the way guest_memfd works
today. I haven't followed in-place conversion closely, but will that
result in a race between when the snp_check_launch_vmsa() check is
performed and before the page is made a firmware page?

> +
>  		kunmap_local(src_vaddr);
>  		kunmap_local(dst_vaddr);
> +
> +		if (!accept_page) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  	}
>  
> -	ret = rmp_make_private(pfn, gfn << PAGE_SHIFT, PG_LEVEL_4K,
> +	ret = rmp_make_private(pfn, gpa, PG_LEVEL_4K,
>  			       sev_get_asid(kvm), true);
>  	if (ret)
>  		goto out;
> @@ -2593,6 +2622,9 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>  		kunmap_local(dst_vaddr);
>  	}
>  
> +	if (ret == 0 && sev_populate_args->type == KVM_SEV_SNP_PAGE_TYPE_VMSA)

s/ret == 0/!ret/

Thanks,
Tom

> +		sev->initial_vmsa_gpa = gpa;
> +
>  out:
>  	if (ret)
>  		pr_debug("%s: error updating GFN %llx, return code %d (fw_error %d)\n",
> @@ -2620,12 +2652,22 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  
>  	if (!params.len || !PAGE_ALIGNED(params.len) || params.flags ||
>  	    (params.type != KVM_SEV_SNP_PAGE_TYPE_NORMAL &&
> +	     params.type != KVM_SEV_SNP_PAGE_TYPE_VMSA &&
>  	     params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO &&
>  	     params.type != KVM_SEV_SNP_PAGE_TYPE_UNMEASURED &&
>  	     params.type != KVM_SEV_SNP_PAGE_TYPE_SECRETS &&
>  	     params.type != KVM_SEV_SNP_PAGE_TYPE_CPUID))
>  		return -EINVAL;
>  
> +	if (params.type == KVM_SEV_SNP_PAGE_TYPE_VMSA) {
> +		/* VMSA page are allowed only once */
> +		if (sev->initial_vmsa_gpa != INVALID_PAGE)
> +			return -EBUSY;
> +		/* Can only deploy a single page as VMSA */
> +		if (params.len != PAGE_SIZE)
> +			return -EINVAL;
> +	}
> +
>  	src = params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL : u64_to_user_ptr(params.uaddr);
>  
>  	if (!PAGE_ALIGNED(src))
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0550359ed798..dc9abe62476e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4870,6 +4870,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_MEMORY_FAULT_INFO:
>  	case KVM_CAP_X86_GUEST_MODE:
>  	case KVM_CAP_ONE_REG:
> +	case KVM_CAP_SNP_DIRECT_VMSA:
>  		r = 1;
>  		break;
>  	case KVM_CAP_PRE_FAULT_MEMORY:
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf..bf034435f98c 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -996,6 +996,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_USER_OPEREXEC 246
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
> +#define KVM_CAP_SNP_DIRECT_VMSA 249
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;

