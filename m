Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57098397B1B;
	Tue, 16 Jun 2026 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643186; cv=fail; b=UvbfFdUBzW6+MAR5gdkfsMg3a+wMfY+AS5+GNrio7N1G8d6uMnI94E3Ie+ita6tACdLGMiIvJIYWYMekIN89OE98le/fJ4Qj2CYA4r68ssA1LNVdSJH3kLnAdj84Ftp7kogKL0xqqHBFaneKKsJq8aj6TGO3GvvdSdHhkJRtB9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643186; c=relaxed/simple;
	bh=pJGBiWof5NqbFC7FEU7SeKPz+Qi6kiJwD1NDka11RHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lf8zcLIVWOpnWaJ+cz7kksZDdY/aMJ0a2KqwOUD/SAhKivlimVdxnBH4ByZnveTdYMF0r3ZHb+/149I9jDBhw8jfhO3GxZ3LbZ49lc1DCrws965LUgymdL93rFTJRocbAMEuZc+JlTv3KBTXs2fWNI1StfwNG7YtMRJgoEkd398=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Drd5KCXj; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Drd5KCXj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKg+h5BfBhYHTo9V0NOqdDWucTycjQQRqO99fPwYKKzfQefJqbl2lgCtJltsSIBLtANMJOPgUHvM0QDsSJuKjhLRKBbs6eni9zVs3R8w5mFjmK8WZ0YbWTitiPldXxvqDMhdTQfUPUYp02GrBO+Bw7bp9xuN/mgtfPCrNEi1oAvTF52pXsgu+VOmDgLBi9OYA1u4t05MKeSHU1Ek2ozioogxKiRfRj8IDqxW9e9rhy/aBHgzlSka41tmGx6NrDiFWit+DcUQR2zbO211ZHunzp1+MlfyDRbPB6kBd4q4h1O/2Fb88sqRRZrNH7RJz76anav3q00wAf6qJLwNdm4Riw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsKzUrVcbi1nN3fhnbskLJ/oluzvqsYj8wR588uMxo8=;
 b=pyM29V7zn0FemW4GDr30VqIIgrdW0oMX34XyV1qFma/PDQxKdQZzJm9xuWhLD7Zw2C8rxIIewhguivmR/5mjrdt45UracW8HaJ36yKdqXE+ugGQsd7fWNaVamc4z7V3sgIypFLaDme+MEbsKFTgfEnbNakZOF90ZhNqurI2Xzqh4TFZJ3j7p13P5puHiJbMfVxwWh4fiRIAljChYA4pS9mAfLksx8JzZXbflXY6w3qwhqfgoiu1D2nd1uIvyHV/zcFvk+kC4hQMhzMcNaq6ToV8EJeDrzQO69TszY2gKujQGvx+T4g6yUM4p+LO41tVujXSG5uG3SlyAGf9w3/lY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsKzUrVcbi1nN3fhnbskLJ/oluzvqsYj8wR588uMxo8=;
 b=Drd5KCXjiVITfuabDVg7Ey9bewBEe+sxvMDxIl2euAsDuSxoxMRQpjphpZ8qYoI0eIzzNvCI64bx/ma751SmWIVxqTm9T4x8UnlCAo9LsvbHU6PkMYNkNrzY05h86rh9XgKChwMNKjstm4q3qAj4RUoh+RCUs79/1RDw1CkFCFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 20:52:58 +0000
Received: from SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2]) by SJ2PR12MB8136.namprd12.prod.outlook.com
 ([fe80::e5a6:6049:4f4c:afe2%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 20:52:58 +0000
Message-ID: <5dc215d1-ea45-4e4d-b79f-0490c1940639@amd.com>
Date: Tue, 16 Jun 2026 15:52:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] kvm: svm: Streamline VMSA setting for VCPUs
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev,
 Joerg Roedel <joerg.roedel@amd.com>
References: <20260611123528.572255-1-joro@8bytes.org>
 <20260611123528.572255-2-joro@8bytes.org>
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
In-Reply-To: <20260611123528.572255-2-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:5:337::30) To SJ2PR12MB8136.namprd12.prod.outlook.com
 (2603:10b6:a03:4f8::6)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8136:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b9490b-589b-4be5-ce26-08decbe93f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|5023799004|11063799006|22082099003|18002099003|4143699003|20046099003;
X-Microsoft-Antispam-Message-Info:
	VUaEJoGGmgoAFbd/czEksbkNz9hf+hI7C6kIGCf62H9etlxYks2I0aocO6KydeB681gFsnNeRlv73UxigDSZADsq13TJOLg4VQc0WfjHSHA1jpXu7aDaTv/icS5mYT9gHoP+Dr+l4gH294JnnUHLHa7ZvEQt9GwokSZ7VbmyL+iqbgEyvurM7rXb3j8twCF65R7H0UeVJ31ZVEJZA/jlsxi+RlYVolGU2PuEl6lcFT+GJXB6fyWHrk6tMGjGUd27SQoVwaaY6S1vrRaRx6ZYqBXT9QR4Hnh5v0srOwxgkCRQDojwQor0utAgNzJ5zPhimbtbwdjmdnTqdWOu8Omz9XRRnRj7AWMMdEWIWHG7cqeMvm5XZzOHMi+1FXaW1wnXKrSQYS9g6uvAp6rhlW43QcG5PSbw3H/CCmgNcC1U8w6Nx4cPigxZRHlJYKhW0Ol/K/MNrdVvJiA8oI3z1o2pv0zhkfc7lb2hzWEnqrrkHhtU+44fr5sbpZ5KJFGmJlXDQK0pf7iMbTqpIKyom28WxD6VABp9I+UyEccl2RBsn3PcQzw5EmvwwvH9rATtmfutvUAAsOklVrPTyHnJ1d6kwPm0V8a7XlMcbd9npY9H0Az12mgOOKZMGEsKWKJNAzGn7nARgkM2fm4/KWHW2BUAZ7cBvYGf7BpsybziuCYOaiwwpjTUhWc+R365UJmZW8fT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(4143699003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVdMM3g5MVhySGFrT1lNVllHYUlkWVB4a2UvRTRQVU5MK0dGM1g3UUQxaFM3?=
 =?utf-8?B?bVdBN09NM0tQbCs4WWFzMTF1Rkt0RWFpRUFhM0ExM25ncEpRMytzcWJMTWts?=
 =?utf-8?B?REFVUm5uZkl0cy91ZkVSdCtoU2R5TTRhdFdIZ2JzaEhnOTZlWTluOWJBczdV?=
 =?utf-8?B?aldsQ0RBVXFIdFNrbEtHUzdNSkF3c1RwdXFhZnhlbE1oMkpHM0dyZTZybjg5?=
 =?utf-8?B?d0p4SWl6NjZ3TmIyQ3hKQnV6UEM3L0ZCejNFdUo3SjRjbFVnbFBZN0FYR0Iy?=
 =?utf-8?B?WkhlSk1oVUJEeFdtRTJZKzBORUM2RDlJd0UrcmZwZk12OS9hOHhOOUJLWXNG?=
 =?utf-8?B?a0V6S2szUEpCUnZDOFpnLzN4dmFFTlZuT2ZReG5USDNzS2s0OUNESjM2U1Bu?=
 =?utf-8?B?MmJpSFhaT1ZTUXRVQVdONG1rbzdXRDRSOU1IbnBESjlHeEtOMVl3bWhIdWUr?=
 =?utf-8?B?OE5BT1ZYNlNSNThPVGdTYms1UXl3UDhGaUVoVHRTMVRkU0tBNUt0Wmd5K3Y4?=
 =?utf-8?B?ZlVHcUhZalVra2cwcjE0bU05YTJpL0pXQUZGeFJObFUxUFhsdHlhKzRyRDVS?=
 =?utf-8?B?d3p3L1JsZGQ2VXRQYnB5TDBXb29iR0dTUTRoV0dvNFNKalUvMWxlczFxQXJN?=
 =?utf-8?B?cFJoSWpLQkV3cEFpOE00Zzd3cVpFSHBES2F1dDNOWXN1ZnA1V2pZRktRclZj?=
 =?utf-8?B?M3lzVFNYRkJ2T1BzZ1lvN3ZrYklRUURWSHZ1MlUycXJadW9SMVBYQmVQb01M?=
 =?utf-8?B?UjU0K0xBN094L0FEWjk5OFdZRWtUdi9tVTZjM3VGRHBwc3g2elplSUZTLzFG?=
 =?utf-8?B?bC9CRDB5aUtXN3cvY2pOdFg0ek9qUVRyMVZ1R29RY2JvOHV4YWhSY05NSEVO?=
 =?utf-8?B?c2JHNkZMS2cwN0hCVjJoWjZocUpDUS9iMEU0WDRkY0VwQjVvbkRNdXY2OVdm?=
 =?utf-8?B?VEloemtkZUNaaEVtZEkraGxVNmpldTdRZnpuOGp3ajVnMHRTZXduQlQ3Wmkv?=
 =?utf-8?B?QUIvUGM5MUlra3NVbUtXRlAyN1JLZkN3dXc2R3c2cUM3WitQMUJnVHZHUkxG?=
 =?utf-8?B?TmNaVHNEMlhjeHhBYzRTWmhUcUgyYWFXa29lVXB1RnJRcXhtMHFiKzQxMFNM?=
 =?utf-8?B?REt5RFJaS05YdFJrZ2RLNHdsdTdtcERTSzRLOU96Z3o1VzFFajJWc29qZnND?=
 =?utf-8?B?NnpnN3JiS1ZEdXlSWk0vb05hMGx3VjE4QjFQOXRLaHhYMjhoUDRVUGNGeThM?=
 =?utf-8?B?cVg2Ny9zUEc5SkVrUzlLY09WSlJVUnRkcFNSQnIvV3FsY0QreXdLWlAwT3dG?=
 =?utf-8?B?NE1YeDNEam1PdnlKZzF1UVlSWWhETHl2SGt5VFFYSjBXMmQ0c2g0UDhiQXhX?=
 =?utf-8?B?aTQ5VU8zRC95alRTbmg1MHk2ampKRmRqTGVscUtnWHJsdW5QV2laOW9kdkgw?=
 =?utf-8?B?KzFJM1VMSjdCaCt2VGxnS3JRbUNjTHBKMUxyMTIwby94WXVUdVo1ZzRab1Nx?=
 =?utf-8?B?V0lMK2dHOCtjcUgzYVZ1OHh0cFFlMkkySW5uWEtwdUVtRnNPWVp4OFR5d0lv?=
 =?utf-8?B?WVNaV050cUwvVWltcGsxQUtqY0Nnb1NXSHVtd2wwN0czd1JoOXJza0hpL0hC?=
 =?utf-8?B?UWZFK2NMUVp1UjZaaUlPcEVIRDRSbnJZbXJvdFJEYUVOYklhaHNqUlNFRUwx?=
 =?utf-8?B?TkZvQi9HR0t0dmZZZDROa01abjBQYnNteEZOZldvRnFwZmFoeCttNldIMkZN?=
 =?utf-8?B?ODdTTnlybFUzUUx5ZDBPR0FFK3ZQUFE5QlR4eFJ6Uy95UVRDRHh1MW5YWmpy?=
 =?utf-8?B?dGFGUUZTY3RYTVZEenRyYmRScVVSekx0d0pHUEdodDJFNDlqakZoa3B4dFZp?=
 =?utf-8?B?RXgyNElFMDBTSy8xUzJyRmZWMUhZY0lGcVpKa0tYTVNZMk45b2xnR2ZkeGNS?=
 =?utf-8?B?RkJBWlhMdFVIVnByZzlmbkE1b2M1TkNTcExOVUV6VHF1VXV1cTl2eW5Sb0tj?=
 =?utf-8?B?b1NhVmdlWjE2VFNZbmpqY2VOeWZRL3JxaWRrUVZ2ZGMzcHlROE43UU51MHB2?=
 =?utf-8?B?aTF6OTFoRFZxd29zSW54NmlLa0d4ZkZ2Q00rNWJONkxENkpPTnJqQkdyZlor?=
 =?utf-8?B?M2Y5TUZlOXY3YWthZUdYcTNMNWxwa1FQNFlzbkVhM0t2SkVmNVJud0xLaElS?=
 =?utf-8?B?a0xPSTJ6RjdWc0hYUzJuOTZTMmUxUVY0V01DalZidnRFTHFIVnVOOHUraHFM?=
 =?utf-8?B?N0Q2alFLSU9IWkx0SzBKK29tMEJaM3dRVXJ3V2s5bXU5QmlBQXF2S1ZmbHAv?=
 =?utf-8?Q?TacAMUavRykWs54eCS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b9490b-589b-4be5-ce26-08decbe93f12
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 20:52:58.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuZD4/4Uo8RgFmcxun/PHLd46gNB7HQwDnPbm5+nFkTVpRsCx7Y/3O4duB6ldT7mBUwyydY5MTp4obKBvnUaEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77

On 6/11/26 07:35, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Streamline the VMSA setting state of vcpus, where a VMSA can be either
> KVM-allocated or guest-provided. This consolidates the various
> tracking state around VMSAs.
> 
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 301 ++++++++++++++++++++++++++++-------------
>  arch/x86/kvm/svm/svm.h |  31 ++++-
>  2 files changed, 237 insertions(+), 95 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6c6a6d663e29..9b1280222e20 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -147,6 +147,9 @@ static bool sev_snp_guest(struct kvm *kvm)
>  }
>  
>  static int snp_decommission_context(struct kvm *kvm);
> +static int kvm_rmp_make_shared(struct kvm *kvm, u64 pfn, enum pg_level level);
> +static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va);
> +static int snp_page_reclaim(struct kvm *kvm, u64 pfn);

Can this be worked so that we don't add more forward declarations?

>  
>  struct enc_region {
>  	struct list_head list;
> @@ -156,6 +159,173 @@ struct enc_region {
>  	unsigned long size;
>  };
>  
> +static void *sev_es_vmsa_ref(struct kvm_vcpu *vcpu)

sev_es_get_kvm_shared_vmsa ?

> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	void *vmsa = NULL;
> +
> +	if (svm->sev_es.vmsa.vmsa_state == VMSA_SHARED) {
> +		vmsa = page_address(svm->sev_es.vmsa.vmsa_page);
> +	}
> +
> +	return vmsa;

How about just:

	if (svm->sev_es.vmsa.vmsa_state == VMSA_SHARED)
		return page_address(svm->sev_es.vmsa.vmsa_page);

	return NULL;

> +}
> +
> +static int sev_es_vcpu_alloc_vmsa(struct kvm_vcpu *vcpu)

sev_es_alloc_kvm_vmsa ?

> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct page *vmsa_page;
> +
> +	if (WARN_ON_ONCE(svm->sev_es.vmsa.vmsa_state != VMSA_NONE))
> +		return -EINVAL;
> +
> +	/*
> +	 * SEV-ES guests require a separate (from the VMCB) VMSA page used to
> +	 * contain the encrypted register state of the guest.
> +	 */
> +	vmsa_page = snp_safe_alloc_page();
> +	if (!vmsa_page)
> +		return -ENOMEM;
> +
> +	svm->sev_es.vmsa.vmsa_state = VMSA_SHARED;
> +	svm->sev_es.vmsa.vmsa_page = vmsa_page;
> +
> +	return 0;
> +}
> +
> +static int sev_es_vcpu_vmsa_make_private(struct kvm_vcpu *vcpu)

sev_es_make_kvm_vmsa_private ?

> +{
> +	struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	void *vmsa = sev_es_vmsa_ref(vcpu);
> +
> +	if (!vmsa)
> +		return -EINVAL;
> +
> +	if (is_sev_snp_guest(vcpu)) {
> +		u64 pfn = __pa(vmsa) >> PAGE_SHIFT;
> +		int ret;
> +
> +		/* Transition the VMSA page to a firmware state. */
> +		ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	svm->sev_es.vmsa.vmsa_state = VMSA_PRIVATE;
> +
> +	return 0;
> +}
> +
> +static void sev_es_vcpu_free_vmsa(struct kvm_vcpu *vcpu)

sev_es_free_kvm_vmsa ?

> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	void *vmsa_ptr;

s/vmsa_ptr/vmsa/

> +
> +	switch (svm->sev_es.vmsa.vmsa_state) {
> +	case VMSA_NONE:
> +	case VMSA_GUEST:
> +		break;
> +	case VMSA_PRIVATE:
> +		vmsa_ptr = page_address(svm->sev_es.vmsa.vmsa_page);
> +
> +		if (is_sev_snp_guest(vcpu)) {
> +			u64 pfn = __pa(vmsa_ptr) >> PAGE_SHIFT;

PHYS_PFN(__pa(vmsa));

> +
> +			if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K)) {
> +				pr_err("Failed to make VMSA page shared - leaking it to avoid re-use\n");
> +				goto out;

s/goto out/break/
> +			}
> +		}
> +
> +		if (vcpu->arch.guest_state_protected)
> +			sev_flush_encrypted_page(vcpu, vmsa_ptr);
> +
> +		fallthrough;
> +	case VMSA_SHARED:
> +		__free_page(svm->sev_es.vmsa.vmsa_page);
> +		break;
> +	default:
> +		BUG();

WARN_ON or WARN_ON_ONCE() instead of BUG().
> +	}
> +out:

If using the 'break' above, then no need for this label.

> +
> +	svm->sev_es.vmsa.vmsa_page = NULL;
> +	svm->sev_es.vmsa.vmsa_state = VMSA_NONE;
> +}
> +
> +static void sev_snp_vcpu_reclaim_vmsa(struct kvm_vcpu *vcpu)

sev_snp_reclaim_kvm_vmsa ?

> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	void *vmsa_ptr;

s/vmsa_ptr/vmsa/

> +	u64 pfn;
> +
> +	if (WARN_ON_ONCE(!is_sev_snp_guest(vcpu) ||
> +	                 svm->sev_es.vmsa.vmsa_state != VMSA_PRIVATE))
> +		return;
> +
> +	vmsa_ptr = page_address(svm->sev_es.vmsa.vmsa_page);
> +	pfn = __pa(vmsa_ptr) >> PAGE_SHIFT;

PHYS_PFN()

> +
> +	if (!snp_page_reclaim(vcpu->kvm, pfn))
> +		__free_page(svm->sev_es.vmsa.vmsa_page);

Should you issue a message here similar to above about leaking the page
if snp_page_reclaim() fails?

> +
> +	svm->sev_es.vmsa.vmsa_page = NULL;
> +	svm->sev_es.vmsa.vmsa_state = VMSA_NONE;
> +}
> +
> +static void sev_es_set_guest_vmsa(struct kvm_vcpu *vcpu, gpa_t vmsa_gpa)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	sev_es_vcpu_free_vmsa(vcpu);
> +
> +	svm->sev_es.vmsa.vmsa_state = VMSA_GUEST;
> +	svm->sev_es.vmsa.vmsa_gpa = vmsa_gpa;
> +}
> +
> +static u64 sev_es_vmsa_pa(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	enum vmsa_state vmsa_state = svm->sev_es.vmsa.vmsa_state;
> +	u64 vmsa_pa = INVALID_PAGE;
> +
> +	if (vmsa_state == VMSA_GUEST) {

Would a switch statement like you have in sev_es_vcpu_free_vmsa() be
more consistent?

Also, you could return INVALID_PAGE directly instead of having the goto's.

	switch (svm->sev_es.vmsa.vmsa_state) {
	case VMSA_NONE:
		return INVALID_PAGE;

	case VMSA_SHARED:
	case VMSA_PRIVATE:
		return __pa(page_address(svm->sev_es.vmsa.vmsa_page));

	case VMSA_GUEST:
		...
	}

> +		gpa_t vmsa_gpa = svm->sev_es.vmsa.vmsa_gpa;
> +		struct kvm_memory_slot *slot;
> +		struct page *page;
> +		kvm_pfn_t pfn;
> +		gfn_t gfn;
> +
> +		gfn = gpa_to_gfn(vmsa_gpa);
> +
> +		slot = gfn_to_memslot(vcpu->kvm, gfn);
> +		if (!slot)
> +			goto out;
> +
> +		/*
> +		 * The new VMSA will be private memory guest memory, so retrieve the
> +		 * PFN from the gmem backend.
> +		 */
> +		if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
> +			goto out;
> +
> +		vmsa_pa = pfn_to_hpa(pfn);
> +
> +		/*
> +		 * gmem pages aren't currently migratable, but if this ever changes
> +		 * then care should be taken to ensure the guest vmsa is pinned
> +		 * through some other means.
> +		 */
> +		kvm_release_page_clean(page);
> +	} else if (vmsa_state == VMSA_PRIVATE || vmsa_state == VMSA_SHARED) {
> +		vmsa_pa = __pa(page_address(svm->sev_es.vmsa.vmsa_page));
> +	}
> +
> +out:
> +	return vmsa_pa;
> +}
> +
>  /* Called with the sev_bitmap_lock held, or on shutdown  */
>  static int sev_flush_asids(unsigned int min_asid, unsigned int max_asid)
>  {
> @@ -925,7 +1095,7 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>  {
>  	struct kvm_vcpu *vcpu = &svm->vcpu;
>  	struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
> -	struct sev_es_save_area *save = svm->sev_es.vmsa;
> +	struct sev_es_save_area *save = sev_es_vmsa_ref(vcpu);
>  	struct xregs_state *xsave;
>  	const u8 *s;
>  	u8 *d;
> @@ -1026,6 +1196,7 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
>  {
>  	struct sev_data_launch_update_vmsa vmsa;
>  	struct vcpu_svm *svm = to_svm(vcpu);
> +	void *vmsa_ref = sev_es_vmsa_ref(vcpu);

Might make more sense rename the sev_data_launch_update_vmsa variable to
vmsa_lu and keep this as just vmsa ?\

>  	int ret;
>  
>  	if (vcpu->guest_debug) {
> @@ -1043,15 +1214,19 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
>  	 * the VMSA memory content (i.e it will write the same memory region
>  	 * with the guest's key), so invalidate it first.
>  	 */
> -	clflush_cache_range(svm->sev_es.vmsa, PAGE_SIZE);
> +	clflush_cache_range(vmsa_ref, PAGE_SIZE);
>  
>  	vmsa.reserved = 0;
>  	vmsa.handle = to_kvm_sev_info(kvm)->handle;
> -	vmsa.address = __sme_pa(svm->sev_es.vmsa);
> +	vmsa.address = __sme_pa(vmsa_ref);
>  	vmsa.len = PAGE_SIZE;
>  	ret = sev_issue_cmd(kvm, SEV_CMD_LAUNCH_UPDATE_VMSA, &vmsa, error);
>  	if (ret)
> -	  return ret;
> +		goto free_vmsa;
> +
> +	ret = sev_es_vcpu_vmsa_make_private(vcpu);
> +	if (ret)
> +		goto free_vmsa;

Similar to the SNP path, you can probably move this to before the
LAUNCH_UPDATE, just for consistency.
>  
>  	/*
>  	 * SEV-ES guests maintain an encrypted version of their FPU
> @@ -1069,7 +1244,13 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
>  	 * MSR_IA32_DEBUGCTLMSR when guest_state_protected is not set.
>  	 */
>  	svm_enable_lbrv(vcpu);
> +
>  	return 0;
> +
> +free_vmsa:
> +	sev_es_vcpu_free_vmsa(vcpu);
> +
> +	return ret;
>  }
>  
>  static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
> @@ -2508,23 +2689,22 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		struct vcpu_svm *svm = to_svm(vcpu);
> -		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
> +		void *vmsa = sev_es_vmsa_ref(vcpu);
>  
>  		ret = sev_es_sync_vmsa(svm);
>  		if (ret)
>  			goto out;
>  
> -		/* Transition the VMSA page to a firmware state. */
> -		ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
> +		ret = sev_es_vcpu_vmsa_make_private(vcpu);
>  		if (ret)
>  			goto out;
>  
>  		/* Issue the SNP command to encrypt the VMSA */
> -		data.address = __sme_pa(svm->sev_es.vmsa);
> +		data.address = __sme_pa(vmsa);
>  		ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
>  				      &data, &argp->error);
>  		if (ret) {
> -			snp_page_reclaim(kvm, pfn);
> +			sev_snp_vcpu_reclaim_vmsa(vcpu);
>  
>  			goto out;
>  		}

It might be nice to break the loop contents out into its own function
like is done with ES. I haven't looked ahead in the series to see if
that would make it easier to supply/measure a single VMSA or not, though.

> @@ -3593,31 +3773,13 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
>  
>  void sev_free_vcpu(struct kvm_vcpu *vcpu)
>  {
> -	struct vcpu_svm *svm;
> +	struct vcpu_svm *svm = to_svm(vcpu);

You can probably reduce the churn here by keeping this line unchanged
and not deleting the assignment below.

>  
>  	if (!is_sev_es_guest(vcpu))
>  		return;
>  
> -	svm = to_svm(vcpu);
> -
> -	/*
> -	 * If it's an SNP guest, then the VMSA was marked in the RMP table as
> -	 * a guest-owned page. Transition the page to hypervisor state before
> -	 * releasing it back to the system.
> -	 */
> -	if (is_sev_snp_guest(vcpu)) {
> -		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
> -
> -		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
> -			goto skip_vmsa_free;
> -	}
> -
> -	if (vcpu->arch.guest_state_protected)
> -		sev_flush_encrypted_page(vcpu, svm->sev_es.vmsa);
> -
> -	__free_page(virt_to_page(svm->sev_es.vmsa));
> +	sev_es_vcpu_free_vmsa(vcpu);
>  
> -skip_vmsa_free:
>  	__sev_es_unmap_ghcb(svm);
>  }
>  
> @@ -4067,10 +4229,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
>  static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> -	struct kvm_memory_slot *slot;
> -	struct page *page;
> -	kvm_pfn_t pfn;
> -	gfn_t gfn;
> +	u64 vmsa_pa;
>  
>  	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
>  
> @@ -4092,46 +4251,17 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
>  	 */
>  	vmcb_mark_all_dirty(svm->vmcb);
>  
> -	if (!VALID_PAGE(svm->sev_es.snp_vmsa_gpa))
> -		return;
> -
> -	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
> -	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
> +	sev_es_set_guest_vmsa(vcpu, svm->sev_es.req_vmsa_gpa);
> +	vmsa_pa = sev_es_vmsa_pa(vcpu);
>  
> -	slot = gfn_to_memslot(vcpu->kvm, gfn);
> -	if (!slot)
> +	if (!VALID_PAGE(vmsa_pa))
>  		return;
>  
> -	/*
> -	 * The new VMSA will be private memory guest memory, so retrieve the
> -	 * PFN from the gmem backend.
> -	 */
> -	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
> -		return;
> -
> -	/*
> -	 * From this point forward, the VMSA will always be a guest-mapped page
> -	 * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
> -	 * theory, svm->sev_es.vmsa could be free'd and cleaned up here, but
> -	 * that involves cleanups like flushing caches, which would ideally be
> -	 * handled during teardown rather than guest boot.  Deferring that also
> -	 * allows the existing logic for SEV-ES VMSAs to be re-used with
> -	 * minimal SNP-specific changes.
> -	 */
> -	svm->sev_es.snp_has_guest_vmsa = true;
> -
>  	/* Use the new VMSA */
> -	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
> +	svm->vmcb->control.vmsa_pa = vmsa_pa;
>  
>  	/* Mark the vCPU as runnable */
>  	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
> -
> -	/*
> -	 * gmem pages aren't currently migratable, but if this ever changes
> -	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
> -	 * through some other means.
> -	 */
> -	kvm_release_page_clean(page);
>  }
>  
>  static int sev_snp_ap_creation(struct vcpu_svm *svm)
> @@ -4187,10 +4317,10 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
>  			return -EINVAL;
>  		}
>  
> -		target_svm->sev_es.snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
> +		target_svm->sev_es.req_vmsa_gpa = svm->vmcb->control.exit_info_2;
>  		break;
>  	case SVM_VMGEXIT_AP_DESTROY:
> -		target_svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
> +		target_svm->sev_es.req_vmsa_gpa = INVALID_PAGE;
>  		break;
>  	default:
>  		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
> @@ -4708,20 +4838,7 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
>  	struct vmcb *vmcb = svm->vmcb01.ptr;
>  
>  	svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV_ES;
> -
> -	/*
> -	 * An SEV-ES guest requires a VMSA area that is a separate from the
> -	 * VMCB page. Do not include the encryption mask on the VMSA physical
> -	 * address since hardware will access it using the guest key.  Note,
> -	 * the VMSA will be NULL if this vCPU is the destination for intrahost
> -	 * migration, and will be copied later.
> -	 */
> -	if (!svm->sev_es.snp_has_guest_vmsa) {
> -		if (svm->sev_es.vmsa)
> -			svm->vmcb->control.vmsa_pa = __pa(svm->sev_es.vmsa);
> -		else
> -			svm->vmcb->control.vmsa_pa = INVALID_PAGE;
> -	}
> +	svm->vmcb->control.vmsa_pa = sev_es_vmsa_pa(&svm->vcpu);
>  
>  	if (cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES))
>  		svm->vmcb->control.allowed_sev_features = sev->vmsa_features |
> @@ -4797,7 +4914,7 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
>  int sev_vcpu_create(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> -	struct page *vmsa_page;
> +	int ret;
>  
>  	mutex_init(&svm->sev_es.snp_vmsa_mutex);
>  
> @@ -4808,11 +4925,9 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
>  	 * SEV-ES guests require a separate (from the VMCB) VMSA page used to
>  	 * contain the encrypted register state of the guest.
>  	 */
> -	vmsa_page = snp_safe_alloc_page();
> -	if (!vmsa_page)
> -		return -ENOMEM;
> -
> -	svm->sev_es.vmsa = page_address(vmsa_page);
> +	ret = sev_es_vcpu_alloc_vmsa(vcpu);
> +	if (ret)
> +		return ret;
>  
>  	vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
>  
> @@ -5227,12 +5342,14 @@ struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
>  	if (!is_sev_es_guest(vcpu))
>  		return NULL;
>  
> +	vmsa = sev_es_vmsa_ref(vcpu);
> +
>  	/*
>  	 * If the VMSA has not yet been encrypted, return a pointer to the
>  	 * current un-encrypted VMSA.
>  	 */
> -	if (!vcpu->arch.guest_state_protected)
> -		return (struct vmcb_save_area *)svm->sev_es.vmsa;
> +	if (vmsa)
> +		return vmsa;
>  
>  	sev = to_kvm_sev_info(vcpu->kvm);
>  
> @@ -5303,8 +5420,10 @@ struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
>  
>  void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa)
>  {
> +	struct vmcb_save_area *vmsa_ptr = sev_es_vmsa_ref(vcpu);
> +
>  	/* If the VMSA has not yet been encrypted, nothing was allocated */
> -	if (!vcpu->arch.guest_state_protected || !vmsa)
> +	if (vmsa == vmsa_ptr)

Can't this just be

	if (sev_es_vmsa_ref(vcpu))

And then you save defining a new variable.

>  		return;
>  
>  	free_page((unsigned long)vmsa);
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 5137416be593..3d4799f09b23 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -240,9 +240,29 @@ struct svm_nested_state {
>  	bool force_msr_bitmap_recalc;
>  };
>  
> +enum vmsa_state {
> +	/* No VMSA set */
> +	VMSA_NONE,
> +	/* VMSA allocated by KVM - Shared in RMP (if applicable) */
> +	VMSA_SHARED,

VMSA_KVM_SHARED

> +	/* VMSA allocated by KVM - Guest-private in RMP (SEV-SNP only) */
> +	VMSA_PRIVATE,

VMSA_KVM_PRIVATE

> +	/* Guest-owned VMSA */
> +	VMSA_GUEST,

VMSA_GUEST_OWNED

This way ownership of the page becomes more obvious when used in the code.

> +};
> +
> +struct sev_es_vmsa_state {
> +	enum vmsa_state vmsa_state;
> +	union {
> +		/* state == (KVM_SHARED || KVM_PRIVATE) */
> +		struct page *vmsa_page;
> +		/* state == GUEST */
> +		gpa_t vmsa_gpa;
> +	};
> +};
> +
>  struct vcpu_sev_es_state {
>  	/* SEV-ES support */
> -	struct sev_es_save_area *vmsa;
>  	struct ghcb *ghcb;
>  	u8 valid_bitmap[16];
>  	struct kvm_host_map ghcb_map;
> @@ -266,10 +286,13 @@ struct vcpu_sev_es_state {
>  
>  	u64 ghcb_registered_gpa;
>  
> -	struct mutex snp_vmsa_mutex; /* Used to handle concurrent updates of VMSA. */
> -	gpa_t snp_vmsa_gpa;
> +	/* VMSA related state */
> +	struct mutex snp_vmsa_mutex;	/* Used to handle concurrent updates of VMSA. */
> +	struct sev_es_vmsa_state vmsa;	/* VMSA currently used by the VCPU */
> +	gpa_t req_vmsa_gpa;		/* Requested new VMSA GPA */
> +
> +	bool snp_ap_runnable;

I don't see this used in the patch anywhere.

Thanks,
Tom

>  	bool snp_ap_waiting_for_reset;
> -	bool snp_has_guest_vmsa;
>  };
>  
>  struct vcpu_svm {

