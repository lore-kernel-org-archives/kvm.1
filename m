Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063B38E8A6
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076718; cv=fail; b=EksuMBOT2kKWzdfjvutWHKR3Qxd75nEhsJSijFC0vavsHnq4tI+fg3amzoEeJtOZjhBVBBicqCSX4qCaThnHA/7BLn998sfayP48tMXWuLw/77L9w+ODPNIG/Ubwm9YUkj6ZrpBHysjGWHsVGBu8fLMzHitwsI0yDJnUjp81jOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076718; c=relaxed/simple;
	bh=vOrezieev3zG8OIbX3leXOVISNyt9MtwYp1twme+Crk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SG0BmJP6216BLUpeyoWli093Jl4dOVxZZqAoSepzOWzqPFU6Rq3yitMW96FIPpUMoHIMHbnCKgZDiWoNe9lBLc1l4kl73vdm6GlDAmqnz3Eu+ZcWmSzmXFEttP00r+52ckVvTPHNIDhs6drKuNgP2YRzctToSly2mTYszhKjvts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=AqcFdnd9; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=fvKDzBip; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="AqcFdnd9";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="fvKDzBip"
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A1uiT03377838;
	Wed, 10 Jun 2026 00:31:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint20171006; bh=BijCh0KuNichbLX
	q0NKY3wc6K6cBN0IeOX5Mcm09WIM=; b=AqcFdnd9kYK650DHMSS6VXg11ZCDCjy
	WprvyA330Dkasb3FQPjnVa99R5Q5GbQC/baO9q8URovehPvZl6Z/NcGPnl7s89O0
	YfHrf+9OeRhgD6W7iTxGlSJvOdjo8WKd1aqe2C01bkwQdlOCoRUu75L+vtWf9doj
	j3TQtegQr7MRjoSsMBaa5+DQtaBh+4kOM5zzFBFMc+YwAJTQjxxXeAwAzx/nRuLU
	rRPvdklX8lFRj6X44x9x7oqdhfk/LMdfxUeqV+5OYunH7x9E+/smJ2lqPIkATUnf
	JO7zIRKUTzrRzwpuCTdXh+YASpKcU7J0t3hXn1szG3MkE48Dgc56Gcw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022115.outbound.protection.outlook.com [40.107.209.115])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4epurw918j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 00:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzdognsn99AlhUp+cE+tlqix2DYim8hFZoKP8KVCBtWzbnBYhv9K8jcE3tR083XFQo/GK2vAqp7+sbNkHywLu7zUdbT6lh/X2wgEohNKNiUmVKPCDK0RsJdkEzKWZrMZiQTcgb7LGZPTOORjaGPMKjbttDZ3w6X/K88DNbJtSMTxNnNVWqEUPcoZCKlQ3XuF7c8OOgh26zPQ+BXpL/VGIqjJ9f6snYtbccSrVHRy4T3DiEP134+5lt8xLztNyoK/IzqZM6MXrE1yFjDjISU7twUdR4PKVsofIXadXkWomIekGVbIVf48EAPifjR+AhEv9lxZJDIGxKDjx44OunULHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BijCh0KuNichbLXq0NKY3wc6K6cBN0IeOX5Mcm09WIM=;
 b=Cu8LTGdzacONs7NIZGeJa5IgDFlIjA/HjbXTyFgc1NWgFffR4uVTc8tKTm9h921ZHxzauiY9o0bdme4uuamn50SNDBrimWh/jK9cLZVaX+FfhX9l80lpBIlXViovXExXJ3+dIZhC5zO287RKTw/n1uPg/Zx6MpsdPfWvPt7qWjoS/yWkCJ7JdgDwfT3gkPXXGo8cUiMKpErECKQavodwGV2CVfeqZ0M7/J2+hC+/X4TCsx+t2xGWGo1/mkTk1ggZnsxfBn8gbASA311XuNPqhli/bq/jwIotzJQ5Vc/gJ57c1PyhuECP5tOrQeKW7iQLzgKGLQ80ejUwYLK9+4Fg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BijCh0KuNichbLXq0NKY3wc6K6cBN0IeOX5Mcm09WIM=;
 b=fvKDzBipyy7BZIcRhw+Lt6Np56SzFsX/+SGdW4g1wkdyGRNSHo7LtCTyXZboGmrrBoSSkA/xErtRaXUMmKwd5ZJHuIhqRIDDbGG+f//23mZv3MvpmvND83xAUCqnfN5Kd5dw3ag51F4mwICRTWwG03GBypk3t8zXRGkh6SX2J+B7Vyy3FgY5EX7DU0Wjhwd4uTKG/2AFtY/hfoQ2VqJy+Z/80YDDS2JQTHHQJcQdZUjZhUzNrwkizYYz/dnSluQaTowNUKNcVp9ZLryBEgTlDAkrlfQYypMLeKpl5QIQMWTQ9y1rfpsScpkYpFi2NnEUOLiIKs7r0Vej4wjkNJWD7Q==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by LV9PR02MB11254.namprd02.prod.outlook.com (2603:10b6:408:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 07:31:43 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 07:31:43 +0000
Date: Wed, 10 Jun 2026 08:31:38 +0100
From: John Levon <john.levon@nutanix.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: optionally post write on ioeventfd write
Message-ID: <aikS2rM4wnJOHZM6@lent>
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
 <DS0PR02MB9321941EFE9070089B6E1AC38B4BA@DS0PR02MB9321.namprd02.prod.outlook.com>
 <IA0PR02MB9462F33B049604001F2469D68B592@IA0PR02MB9462.namprd02.prod.outlook.com>
 <aeeNiQf6NMJk9zKd@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeeNiQf6NMJk9zKd@google.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::12) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|LV9PR02MB11254:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d3c651-6aba-41ed-1d71-08dec6c25182
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	XexaRhc0nd7+4pHnaatTs/2n+hzekSeMJ0GuC22AOuLTDptJu93QF68FFXG83jIZXjLATot8SbOi9UzPFcEonatf0IVh8J9/Me/aLqR/g9b2LxpOyQlYNsSnafeS7JARTpsWmA/B8SD+ZPOdb+oUPAww2wJyThcSL0A5lRewTbSqLk81GRWkfQwqPF2wuNwC5eD/lUhm7KcqWTYLBVp+hwzTrMCaaRhf26gMbaX7nwxa6JSUaGfzGPyMPCRwvJ4yfnno+XZuba981rmydYgbhuf7yRVPs7V+kYJzsBDVeB/DGfBl9p4yJ273/7KEEi1s/noB1lP0Ywop9+tubSBdW79MbNXNq4xY0bhoW6xC8F6xLOES1anIcHHGSpv6wCpLGbROnlLMZ77q0RsdEQv414ulZ0PLx5f5p8ZxVAsEYmGF0KlA2gaus//pUINk+AlJ1RWlk2aAkEdCehVJxXrgCT44DYOWD3EYwtOZotdt6ZYH3ORzaUZMof7GpOQ+wA6gSXIyVNNHwTQOpiItCjYOh2a4jOnBV3+Y3zJmA8TuEdhiJcO6PuRgfhEOoCHcMUytC4fmowcuU+abk60vWHMeoAE/xfw9lQ1+PtROHFNfFeUemoPAEzXxpgYjoIKQ/ulCNOprPidlyCqgZm5dBmLja+1uyRgHDzYic0A7+v74F4hW/+JzP28oPK12yl1kVaQQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6753.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FpaJKB3AdVTKk8TDTVkb1aR4lSFjaoWD5Qhpz/aExYppbiP9UcSDsetsH7Gv?=
 =?us-ascii?Q?lfMi6HrVEB1f6cPP+VJ42HFs66ehaY1q05OrIDzgWhn3MZMAXhu3R/2FQ/lr?=
 =?us-ascii?Q?oofCbWWUz+Oi4f3yLbOmq7qHzHYFJoa6dV/ufAO9IEQmxo7GHoif1rRUbyCs?=
 =?us-ascii?Q?WctMWGM2OidKn/QFxw9hLtOA6PKfTFdYDIwec44rJ6vgGE3n0aeKV7lEUHUQ?=
 =?us-ascii?Q?p3mfbdvLnLVZSUru6tg/MO1IzqXkvZDhlLtj/wk+9HXGU5E+wnzsZCDc93yq?=
 =?us-ascii?Q?MFJ2IlBNeNR6/y/CU4gE4binCv9icEe0OdGGRQ5KCPeOv0zWD+nVz5V4HJ/H?=
 =?us-ascii?Q?MRmwqqlZ3LVn8uk13ouHWHO2DM17vESIJWbodkNOPM/L1gvd+xkeTZHWrWdm?=
 =?us-ascii?Q?SKS7CJ8rDOYCeLm8SFjpV/0eCnt/5J4uNSWj4jiXOFCOdVVDImMTtY5XFm9F?=
 =?us-ascii?Q?RgQF/iouaxMwv981yL9d9oyKwAjWLPwbDPQBw2uaJXW+8i7f3OHsIEIoHrnu?=
 =?us-ascii?Q?l9Eo+ZCqq5RTrcoe+MoyqbyM8vF8kOtVI+BdQ57qiD8AzM3qTETs4kH/n0rX?=
 =?us-ascii?Q?moalLC6gclgsYVEZLZlKZAW0Sr1AoREUheFGORDqXXs+DurN5ORIZm81jnW8?=
 =?us-ascii?Q?8GUoHnk3zihVkFW5Lao9L3jkF7Qfp1Cmo2JDd+k7Tkf0XTBNhKm7O++8Ib+H?=
 =?us-ascii?Q?FhuZi4LqpuX3hOQyZJqgJFLMW1V8CCId8YtjAptO+FQUAKW3uq4zUeUEit4Z?=
 =?us-ascii?Q?BUaZYuwqhHI9ZJxLTwIcjDCneYBhiTodxGFv4RGR4Z+gg8GFGBtReisHojLE?=
 =?us-ascii?Q?UP9LSQA5L7OCzQTHZcYBUWCL4R9+VHZuXNcujNgygrOQeaZIda8hJYT8JePX?=
 =?us-ascii?Q?ItcsOYVg3UkKZelbt6RBeOPdRSFekp0jDs0HBZ42RQFsRRqCnoetARSWVlKn?=
 =?us-ascii?Q?Xvrgd9N/IMwc5hK0dfUqmueFmQ4FfdN8P+oXezPXfgbndeUP0EpFG7QWeJvV?=
 =?us-ascii?Q?+1g2ZgFz3iuAU8UYyfMqHqwcDN81m6orGbMQ0zuMkUO7t0BTeMyGcA2402ST?=
 =?us-ascii?Q?Y3MmHzz40mCDwCfopL+TJFzteCtZ0cb0XdfpC2j2kxPqEgJkibxAKBWd0x9R?=
 =?us-ascii?Q?TL8hCKMmF9tuuEij5UA10EjCLZHqt7uEi54n79egJ+Md4e99gVxQPXyfPYPy?=
 =?us-ascii?Q?I55bu/7UK2xUT1S1UqSJlAWEQbmJcQuxpl31uAlrHr1Qp3mWXXQEr4ivlKt6?=
 =?us-ascii?Q?A8wzbGSOrafc4IuVjLr+ylznDLGc0C61xqzP3FYnCBuDIdi6NExp0AMtmwjf?=
 =?us-ascii?Q?rpARtpYfKF3gG8YZsCJtJz3RwnFmJA6wO2zKtzFWTWWh/oDIDoQ67qDHu68V?=
 =?us-ascii?Q?XUi5h2Qe4+5dAriH8fMrqaBBIYLEsvZeCo7Y40Ru/v+rImef61JwQW+pD75F?=
 =?us-ascii?Q?uXNCczZDyNW8iut8V731pR01wlxOWn+xYuoy4gl4bWw6RcFpkmIQ+AQWlarw?=
 =?us-ascii?Q?cWanfZli7/yfaXToKDqFMtob8AHGNnT9m+GkYZZPHfFbToSZ47JLoqcXmcmc?=
 =?us-ascii?Q?iYOX1nDmr50ppZF5bOcrImFK4afRwqSiD0CBWgoEzYthVRl3j7xELcIzAGNH?=
 =?us-ascii?Q?D7fJNzFYtfU36cGRj7zPzQpP97/jInHC/whWdtMIyvjU2hXIvhUZVrAxnBnL?=
 =?us-ascii?Q?mXu37DAEHEpF5WPxmZaJRMQY0xxoUgDjVO27FiSECNSq54NVEHFkLzg+JMnm?=
 =?us-ascii?Q?GNfZ+x/V2Q=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	Ra+sSlYuG/aBQWa+9v1wpinomLKshEHvjwW/ngAr5F8OnCop+cTnpIbR0XgvYSnJB/h2jPtKawY69WO9yikYVZY0MOnb+ZTXpxkTrhLEBsCSV+VbSXsb+bAXxL1RdwPiTpGZJJYhoY5123oN67NNivAlHQCQs6Z6jH2b2NA8x0DnfUF2+e4ksoVLR/E/inzjo57z6Lk3Jrj5qurQBfL9vihlAsrOg/VzwREEqPW/hst2wlxFTzSp7aCc7LpgHEazkmShs7En0brgyu5OWU0p4q/k9hnEcDicMNAmZzNye1GFp6kVixRQDNwHhC0daROz49QoTLahr1t0Eype2HRU0Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d3c651-6aba-41ed-1d71-08dec6c25182
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:31:43.1324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRrFeWvm5YMgUr3kpMfgHRl4LXQqEQHcVUEDE7CpTQdatoJsBnsiTZyKLpN/Bgu/r8tC40WkVFlbcOlfpjAa4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR02MB11254
X-Authority-Analysis: v=2.4 cv=D8137PRj c=1 sm=1 tr=0 ts=6a2912e0 cx=c_pps
 a=ckbzw8NX8UamirBUBM1bcg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=6eICeqM_5eHyIkndcyoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: XhMboYuM2GOfYkR1s5RYsDMu7SFFweHJ
X-Proofpoint-GUID: XhMboYuM2GOfYkR1s5RYsDMu7SFFweHJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA2OSBTYWx0ZWRfX5u8lcwy0m9o8
 egmvGRr6lwP/97klM6LKBn8VG1idRfhM1OSuQ0f4TtwDTNpLu7cp3k7A0hSZMkUiOjrp0AWKpda
 NF1mpMJeSYHPaLrZFkNbBVvvAyBzMNV+mipiwDndE5kM3QZL8OiCHzoHInSUJI6meTmIf6U0xl/
 HfqZSLpT1T8aceOP19nNWKrhj9ucVkf7wQH+fryegMCxwh5qDDHDChEFibAP7iplFO7xlXm6BDH
 XcZUOn8P4w5700NrW91ZuprcRTMr81sqrz8CvD1/VCqEIm7c32Jn6nx/+EF4XhnHCj/cjwqD9Ar
 JhQvTzh3jN4nn0/AyzcZdY1XdnLlSRHZmClFj293dFSU8tSQkQ1ZFPmBtqRTIs89Bad+sfw5a6q
 dNZY53EgdKHSA/6LuVBr9CbZykC3/bXpekx0wsnklNAUFVQjZH6C3vUuPLI5KGkWp7cLX5difGO
 9pfAegBPUVJ8adEj0FA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

On Tue, Apr 21, 2026 at 07:45:29AM -0700, Sean Christopherson wrote:

> On Fri, Apr 10, 2026, Thanos Makatos wrote:
> > Hi Paolo, Sean,
> > 
> > Following up on this, please let me know whether this is something I
> > should revise/resend.
> 
> No action needed on your end.  More discussion is needed to make sure this is
> uAPI that we want to support long term, but we're not waiting on you for anything.

I appreciate everyone is busy, but I haven't seen any further discussion on this
since this email, and I have people asking about this feature - is it possible
to get an update?

thanks,
john
