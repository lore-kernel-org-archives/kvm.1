Received: from outbound.st.icloud.com (p-east2-cluster5-host3-snip4-3.eps.apple.com [57.103.79.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C96136EAAD
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776426913; cv=none; b=pWC42B88zaz0WJIWYpvXfrs9ymLaaj5mg7pD+Ry2+sk4hZN1xaLqUa0akG4lCo+cV7ItynF8X8h0ffOKEizTKJPY7I8itzBb3JicqxYYjAg9GsEMFg7uDb6EwE9xiA6+DyJZcz6q5UY+w9pIm/e5+z4gwgfBaMKv3Sk5ibrj2Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776426913; c=relaxed/simple;
	bh=nXqnTXy+699GTVHqkhAMQn3H9jefinE2ZXkW9yCUYZc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=USO+B30KsxnwbJWhHf5X5y64cQlIvMh7z8/XwnZ6oWeeFvP62CGuDhvtt4sU3HFZG4Bg6C01UiZxorEzYk/bIQyl551pJfFBd+WGgjmn+wZwvSVz+YiDp2pJ/otBRJMrGX8iXKGsftiR2Qxa4vF4aEz2mKSSgggsHUhkL67kyrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unpredictable.fr; spf=pass smtp.mailfrom=unpredictable.fr; dkim=pass (2048-bit key) header.d=unpredictable.fr header.i=@unpredictable.fr header.b=WL+1oB3W; arc=none smtp.client-ip=57.103.79.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unpredictable.fr header.i=@unpredictable.fr header.b="WL+1oB3W"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id D0988180015B;
	Fri, 17 Apr 2026 11:55:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr; s=sig1; t=1776426908; x=1779018908; bh=nXqnTXy+699GTVHqkhAMQn3H9jefinE2ZXkW9yCUYZc=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=WL+1oB3Wth99iv4Cuntx7z3uffNZER1TqHkbvgo0aIx4VPoiYRdzRZlXPqikFx4QQfHNA6uIec5HjQ1bGyP4oEUcqQK3EtAZ3KbMrofZgKtPbtfwRkB8FCZJxAambrnu++fJ9HsWd1rqKr4p8CxJ154U6igwrN80e3B/TXyfw0f2V7EBqtGBOyWCNuSDszbtRFQj5XCCc746whyqSkIKT4ueQPudb2if2esTAolJG6y1vgXKsZg+/1ym4kj1rLCfHU4VwBKFr45sdlgfbP3olr6yNUNoUCQr/dXb2SqWrzmE4pq2x/vtFkW/vRWmh+7Qb66BJZ+uEwDtCcW3vpYv6A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id D1B16180060E;
	Fri, 17 Apr 2026 11:55:00 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
Date: Fri, 17 Apr 2026 13:54:48 +0200
Cc: qemu-devel@nongnu.org,
 kvm@vger.kernel.org,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E651C54B-3AE5-45B6-A275-26C415EA0582@unpredictable.fr>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDExOSBTYWx0ZWRfX4HkXDuQJlgoH
 5KaA38QdO+yP0GeJVkjkE22PQnCtMhWGUytg9NAL5FItcuu4xkA2c9qCRU8wUnjqpAGu+4kh9HT
 ISJzOz8Mfmo0CAWiOyaSNhjmWLLDYXpMGhjZuWDknnAWSspv8GteO54VgF2bNJjW8pvoRDdFfOm
 ikNH7i2e9fEn8yGpRUhBaK+zCa2Rf1i2vA6ZiAOQNHPYSPhB6c+T9zy0n/nQn6qsK2fgpQBpNGL
 7j6H5GbLxyTfie2W2+IbprEIFYt/gScsC6u1mtrShUYrTIWndpHMyscvIuttuQ+W/BRaSh0/cyA
 u9txctmi1mQI6SNQGTvY/Q37lMuID65Yn/fZVf4JllIIe4Vu7CGhO3/wpz11G4=
X-Proofpoint-ORIG-GUID: k0V9sTe-vipaBHgdrdyeAM49YqEk1ogZ
X-Proofpoint-GUID: k0V9sTe-vipaBHgdrdyeAM49YqEk1ogZ
X-Authority-Info-Out: v=2.4 cv=e+8LiKp/ c=1 sm=1 tr=0 ts=69e21f9a
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=a1E2onep4z3RYCm5l0cA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=765 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604170119



> On 17. Apr 2026, at 12:56, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> This change implements loading and storing the hyperv lapic state as
> part of the load/store routines for a vcpu.
>=20
> The HyperV LAPIC is similar to the the split-irqchip in KVM, it will
> only handle MSI/X interrupts. PIC and IOAPIC have to be handled in
> userland.
>=20
> An opaque blob is added to the APICCommonState, guarded behind a flag,
> hence it will be covered by a migration, as we declare VMSTATE_BUFFER
> for the hv_lapic_state field.
>=20
> In the future we might want to introduce a dedicated class for MSHV, =
that
> would require us to wire up an IOAPIC delivery path to QEMU's userland
> emulation.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Hi,

Is there a way to make this not opaque in a way that retains the ability =
to
Save-restore between KVM and MSHV?=20

Or is that not a wanted goal?


