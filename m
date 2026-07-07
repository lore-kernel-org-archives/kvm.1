Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013050.outbound.protection.outlook.com [40.107.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580883EBF36;
	Tue,  7 Jul 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443519; cv=fail; b=iiNGZNo54w65fJ2m+b0Ukr5wwfiGaOZPpVztpGuiRIEn/n1PjMGL8Z6iXUJeKb0yiR+Zy72SM5lZpRQoJJkV+9YUD4o7WgjTSUxKRRDbUYnumvao0nOyAnbnneLowjfIS1l34i3gGai4osc7waBcvUjnTWYKsaN98Z/WXOCAkS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443519; c=relaxed/simple;
	bh=NPuYhNQJPyNLZt2fxQtdBdzaoxSCgsPi2euCTYsJTVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q/ozqEY+yDZoE80BNrYimWjLB+C2AZH66vGH7ERMQqhUTMcdaEpDVOACij06EZ++YpkJWAtn00ZSUYeVvpouM8A34YFQlSIN8Vy8ZAR5tnPGt6xSgFriJ1GUdBSOmAQ+zvN16bixVuOqYFhSbXkeDziPI+nPxHNGWJ6X0v/ToKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fdhEUIlk; arc=fail smtp.client-ip=40.107.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fdhEUIlk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jp8FiruG5UiQhIuEtE1ib3fjqBEtX2smCyX/Ft5OSD2z9sTN2O5J7TmzXiUOC3uZqnArx314IP57xbo7Q6EBam2lHluwR4w8iL7QUt4Z0SZaw7E5ShZcbYYlYRuriEEaa12fpL/lEPsxSzzATiXPbi5tY2MPZAzs/DxGsnHaOeXjVLlAUyjTjW2hSTEOBwUy0tqVmGXj6uYFfQ5NxgOdWMwcqsWmx60ZHkbo+N4e77a7p4g0YZUL+PPr4eypJox8GgTEbxXeARDUhO7JzV1dG3jf5O1Ue4r3GP+3Lc+Y9tMwlzHHB+S7Dl9ZS8jJC4Au6luWYTCPFUIeZ1OSV471bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U32bOPjPzip6Ax5fZr9EqMcWOKJPOOFlyicZq2kWk3g=;
 b=p8QrBf8vYluGpnd5xc1bVIDvazQEWtVAGD5CjgaYUuTcOEOrtPchN0a9j76TP5X9S1NWT5SqewDY9OcS2ZqFNz6Vb5H7miVWAJoxXqFmoqqnayUg8Ww8BeYtuJ48du8E6wk+t6DngKAMdMNR4hYuPiqcpvpLurU07wiXoVeH8MXtOZuQF77rVJpeIgFxem81n7tP45veUIQ9Zn5ZgAoH3t8NUBDBxirABawWaY4th5rwE2swf70+ImJL7Ge8ugQ2G7V/Uqks0defuclkncb/t1zMuZKzoux/GVzAQrN+XB1scvy3t5DroRDh5ufiyAaGKNxw+32aoC4tOnZnwZsBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U32bOPjPzip6Ax5fZr9EqMcWOKJPOOFlyicZq2kWk3g=;
 b=fdhEUIlkORMlcgv4tplz4LrJ9sw9kyo2lb4mxxd2F2rI47IgdvhTafPX+03pQdJUdt6Z2jsLsnP9n1f8vn0x8pDzcw7y8Hwj4mQes4/n/ciszq7HB00WP+ypm3MhR0Q2dhvgEEaV+I4/3rV9yQGlRYL1BFKGIKRSSWaQZB0zd5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 16:58:30 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 16:58:29 +0000
Message-ID: <ebce06ba-9d7f-43ef-9b3f-aa858348fd06@amd.com>
Date: Tue, 7 Jul 2026 11:58:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] KVM: SEV: Fix RMP #PF due to freeing in-use VMSA
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
References: <20260630222607.497895-1-seanjc@google.com>
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
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::26) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b08bc2-bdd3-4e86-b971-08dedc48f86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|22082099003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	B+w3qct/J3BQHsS9bZjR+zXSUapGd2gyVBw+2K+RYSp5EBvdBsc0JxK8+kNRETjDMmMh9D0085LuY/q7iJtJf3JyS0JT8pYY4jBtyuIu2quUXebIF/w7bVmGm5p1o9V+VzDuqR6RlKqeJNSAeA/LgvBOiva7urEc2HJonS9i3LI1GUAMUAwHf8sdu5I8VZghKmMdNCgR2ujVGwDSExBw3bKkv1dY0l1FBF40CgBuR1ZVWC20FaEfZp5M6ACLDvO3iwRERh64RjnqvKMyBWAsQLon3ZnL89Jgxj8jPkJA/e6u83YEo3okRETcRtpbKEJ4cEf8/hs9n4+L1y+3SsK8IfbTlPbtpNb0ju9O+jYVcXcM/a3Qcm/zZmGn1iqB3HO4KD1osJfrTX7BjekOCrBWtxmDwfQ8/OKuGfqg71MBZcrX9GrxKbzx8gV/RrYJKJXOzIK6hvXUNs7H+lkZwW34oRkaQd6rAXtH16QjFDoqBl3gseVNxjn+h5tC64XVmr079Nsaso33g2fCj34t3wdoK+06RRSPCJqaoC29FPaGUg+S0FOxeNJHR/VnIlVL7Lq6/25pTJxVc+2T7zWFHMcgW+fTu3glEacat4LHwxAtzOV0yznM8ho6JaQxppJyJ8jGAFepQcBmyjpVlX31w1BiMCGr+R2UqBAw9X0fa601pME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(22082099003)(18002099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uzhqb3dja1lJOHFKeSs0M3A3WndnajJHZS9Jc2o5bEJzK2VQYTdnTHoyV1JJ?=
 =?utf-8?B?cDRMZHRlVk8yZjZyaXVoODRFbiswcWFxc0YwcXM4eDZDR2pYZjRPRmZFS2ky?=
 =?utf-8?B?TFoxeTlOREpUbFNwTjUyallIenEzVmd4b21QaWxTaEZMYkNYZ0t0TUhJNEQv?=
 =?utf-8?B?L2VaWFE5NXpBTUJaYTN3TUNCUURiQ3ZwNHR3RGQ4YTdXcFZhOEtoaHNsdHlu?=
 =?utf-8?B?ZlhHZkZBaU1kbFZRL0R0VjRlb1J4M1dVbVhyYXpVWW1HblJxV0szd280ODdz?=
 =?utf-8?B?eENKckNocWdhQ1NCenltdWNvYkdUTmk5VE4vbmtCTXdFbjUyYXlrb21Fd0Qw?=
 =?utf-8?B?Y2xLcmh4Q2Jhb2p4cnY3NVBWYklvWis4WlBGeENoQ1RFZGMwOG1ZdUNkak5j?=
 =?utf-8?B?SGZrVXpXTk54UmlrbDYvak1pcFNmWnVVTzkvN1hQUWxKOGhLd3NmT2ZBWnJS?=
 =?utf-8?B?RzdMdEt0WS9mTDZYbHZPRkZseXlCSUlpUGt5SUxqSXlicWNEMHptQlBuWVYx?=
 =?utf-8?B?SitjN2FKZ1lmQnRsaDArRmNPS2dMenU3ZmVkaFJxdXVWQk1vZlBacDllN1FN?=
 =?utf-8?B?a001Q3BweFdnelBaQjQxN24wYXY1UEFxYW1LZldkMXl1UkZyaFVuTittc2di?=
 =?utf-8?B?S3p4cXpjSjI0dlJuQmwwUmtFdjhMTzZtejdMMllrckEwZmllS2Jjc3YxQmlH?=
 =?utf-8?B?U3lScGxUS0V0Y0oyQ0VKVHd1Q1hSdE1pOXJPMHdwSTE2YVZuS0p4UlRNREN5?=
 =?utf-8?B?WWptaVBEbDNLcU1PUXhHSzg3a2hLYjc5MzljNHJXdTNIVWRLb3h0MmhkenFQ?=
 =?utf-8?B?NFdpN2N4TlF2VkJIMVZZNEFxbTJJeGRPZ2NHY0xQV1ZoelE0K3ZYNmdJN2lR?=
 =?utf-8?B?VUQxU29nTzJUbUxzbVpKTDV3b1VHaWZRU050N3FjTVpaeUxHc0dKamxsb2lI?=
 =?utf-8?B?QUFYUHM5RFdtT3hkbXlUcHlJbFB6aVBkM1BOQ2kxUnVJMXhEelBqeWFaaS9O?=
 =?utf-8?B?aDVzQ1lTd2Vlb21tT2JwTmZtSHRDL2NHbHdJeEJxcEJLRGhQZXFydXYrZmtl?=
 =?utf-8?B?WGxGc1JReERwZjdIbUZPMnBhQTcxU1R6SXpYL1BDek9ZQ09sMWNvWU1BbUd0?=
 =?utf-8?B?V01xREdZVWlWNC9zc1RlTHRxUUU3RkxtWTFyRmFMOGRMZ2dJWjBDd2tPM0R5?=
 =?utf-8?B?M0ExSlY2cmk0bXBPYk5JOHBlcjJxT25UKys3anROWTFIek5mbFVWVkVyZHVY?=
 =?utf-8?B?cEw0NjlxRU1oc29kTS9IZFQxcUpuOXN1S2NGQzBzby92aVVwL1d1U0psOXRQ?=
 =?utf-8?B?aElMY3grWXRERjhkaXRmUDNUYVhuNzZUWmtSbXRqVk4zQW40bitLaGptS2wx?=
 =?utf-8?B?K0phR014ZmZ5ZXV2SVRxWW1MTjZGUmpQMmVXUkRLT1VsMll2eU5uOURONWZq?=
 =?utf-8?B?cXFqZ3NLaHBpbjNRTng5bklYSk1NNnZ4Ky92d0JvK0drWlZqY3ZtQ2lTbWtX?=
 =?utf-8?B?QlhHV2NsajdkWUJoMzU5WmFwQ2E1OERNY3dzUGdPeUdLRzY0b0hBV1BBS0ov?=
 =?utf-8?B?d0NuNVJlNXNoQ1J6ODJNanpjSm1jU2xJakw4S0xUYytIZDI0WGJhKy9HS0Jh?=
 =?utf-8?B?N0pmS1k5eFhoajJoVFBDZ1lXQU40Z1R1VmJpd3lxRS90ajBXeldBbUdUWDlF?=
 =?utf-8?B?QjdzWVMwQVVKb0VQVkIyMzNKS05CMUhpMzJWTEkrNGIxUldmeFd5eVg5YXJh?=
 =?utf-8?B?NXRRRWg3clQ0ZnUyYW1pMkZ1RjV4aGR1bzRzL2FZKzVFVVUxYUsyWllZaVdY?=
 =?utf-8?B?YmppWTI5VHVWWFlNRElzVDJIR08yQ1gyVEkvYy9wTkFQQmNTM0pjRE9QQmNu?=
 =?utf-8?B?akJLWUhkWjJsVzluZ1hHSWtmOURrUC81T0JKbVlFSURHZ1M5WFFpd2kxaUNC?=
 =?utf-8?B?cDZCaXJVakt5TlI3eVNqd0pPVlIzQW11SVZJMithN3NIOGQxb1lMMFlNcXNr?=
 =?utf-8?B?ZVA5YWU2YmZsL2dEbnJGWDhHZVgvMWQrWlo4bndyZFBzZE1NU0NuL0JkMGlo?=
 =?utf-8?B?U2FjNGxYZUpheUpIVWxqNDY1TGw3cXdYY0ZyMFFpRXpMcDBwb0didlhxNXJx?=
 =?utf-8?B?YWRPbzFWU0E1cElEMHRENVdsbEVqWlczUEV4UWtPazdkdndFMmZpWHpncUpl?=
 =?utf-8?B?eGlrY3ZlMTd5djBOWjZLR0xicXE2UWxpdXJQNVpwY1dncVpoNUN3NVdsRlRS?=
 =?utf-8?B?N2lrNEQ4aS9mSnFGQkppN0k3NkhXT2k2aGFLZUlUZkNjZzlpZFI3YzRCZkcv?=
 =?utf-8?Q?MtSoQGMn6OA+2qqB2+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b08bc2-bdd3-4e86-b971-08dedc48f86a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 16:58:29.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4TC7a2XF2rxaooNA/zJGHGnqb6dq/8Wy3d/UOrmr73OIi4AUOFBrfOMhJz2AkVEmHS3EqAlbKAi4aBlgfkC3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

On 6/30/26 17:25, Sean Christopherson wrote:
> Rework KVM's handling of guest-provided (and always guest_memfd-backed) VMSAs
> to forcefully reclaim VMSA pages when the pages are being freed from their
> backing gmem instance, e.g. in response to PUNCH_HOLE.  In the worst case
> scenario, marking the page SHARED in the RMP will fail due to the page being
> IN_USE, ultimately leading to RMP #PF violations due to guest_memfd freeing
> the memory back to the kernel while it's still assigned to a VM.
> 
> Note, the implementation nearly identical to that used by KVM for VMX's APIC
> access page (which isn't guest controlled, but is migratable and whose PA is
> shoved directly into a vCPU control structure).

Looks good. If you wanted, you could replace some of those quick
mutex_lock()/mutex_unlock() and write_lock()/write_unlock() calls with
scoped guards, e.g. in patch #8:

	scoped_guard(write_lock, &kvm->mmu_lock)
		__kvm_mmu_zap_all_fast_front_half(kvm);

I think those are all available back in 6.12.

Thanks,
Tom

> 
> v3:
>  - Ensure disabling quirks while the VM is live won't result in KVM skipping
>    the back-half of "zap all fast". [Sashiko]
>  - s/gmem_free_folio/gmem_reclaim_memory. [Ackerley]
>  - Use {READ,WRITE}_ONCE() when accessing the guest's VMSA GPA outside of the
>    per-vCPU mutex, and comment. [Sashiko]
> 
> v2:
>  - https://lore.kernel.org/all/20260626231416.3943216-1-seanjc@google.com
>  - Invalidate VMSAs if the memslot is DELETED or MOVED. [Sashiko]
>  - Limit stable@ patches without a Fixes to 6.12+.
> 
> v1: https://lore.kernel.org/all/20260625222229.3367197-2-seanjc@google.com
> 
> Sean Christopherson (12):
>   KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP
>     guests
>   KVM: SEV: Extract loading of guest-provided VMSA to a separate helper
>   KVM: SEV: Mark vCPU RUNNABLE after AP_CREATE, even if VMSA is unusable
>   KVM: Rename .gmem_invalidate() to .gmem_reclaim_memory()
>   KVM: x86: Serialize writes to disabled_quirks using kvm->lock
>   KVM: x86: Ensure runtime reads of disabled_quirks are resolved once
>   KVM: x86/mmu: Fold kvm_mmu_zap_memslot() into
>     kvm_arch_flush_shadow_memslot()
>   KVM: x86/mmu: Split kvm_mmu_zap_all_fast() into "front" and "back"
>     halves
>   KVM: x86/mmu: Use split "zap all fast" helpers when invalidating
>     memslot
>   KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is
>     zapped
>   KVM: x86: Guard .gmem_prepare() declarations with
>     HAVE_KVM_GMEM_PREPARE=y
>   KVM: SEV: Mark vCPU has having guest-provided VMSA even if its invalid
> 
>  arch/x86/include/asm/kvm-x86-ops.h |   8 +-
>  arch/x86/include/asm/kvm_host.h    |  10 +-
>  arch/x86/kvm/mmu/mmu.c             |  74 +++++++------
>  arch/x86/kvm/svm/sev.c             | 163 +++++++++++++++++++++--------
>  arch/x86/kvm/svm/svm.c             |   6 +-
>  arch/x86/kvm/svm/svm.h             |   8 +-
>  arch/x86/kvm/x86.c                 |  15 ++-
>  arch/x86/kvm/x86.h                 |   2 +-
>  include/linux/kvm_host.h           |   3 +-
>  virt/kvm/guest_memfd.c             |   6 +-
>  10 files changed, 210 insertions(+), 85 deletions(-)
> 
> 
> base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370

