Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.64.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795269733;
	b=0ZrHuPfy02k3a6cxuJmaGYfgTrJB6W6RcugyWei39JejUtoFaGT7+todEXv+FQpgwv9f
	 nBHLmwJXL90EWcRtxvv7oR3qvBUNKNNlD8IKYTcAg2WJHoRx/Kgx6Z3EP85VYccr0w/GW
	 D3iQU93loCwkUHxqASUs7qpV8Q1tVZQPphCNfHkxggzKv8heFck8E2wmSnlSeFuddS0PZ
	 xExQTH3G2WQTuFA12AxcG8rB757jD82p6F/YEIyUzKi2CDHi8gDah2u1Hh6Lq8dt9yINk
	 fKkgWVZ1NLyl+hEmsqgB5ZVNLMO+wJQEJsGxqIBPxS2O+UnH/IDaJTM9wujhepidGUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795269733;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Info-Out:X-JNJ;
	bh=wMttAGKaKYn3TG91ZM0cBnO+/ENftVqYZypNHoi8/zI=;
	b=XCwskYYTEJKAJ4hyz54AAUaUoHLzdbHtb1Tm3Jb89isKcx18RToUczB0eeV/ECTDs0dn
	 AyrAT/oIPrdtDAQ4fpzyiLbNIhD0hypX2f8kMmeIkNOAM2SYqBTvRc9Y5QPfm9fWIL9IA
	 JqVj/gmCLZpOsCsYqqyhJuFpaYYmQqdEa0Tk4h34yeV7EyA7+PyRDHmZ9fe65xvDS+ET7
	 NNWGUNa/zFfcG4+BDGzooA4N6pFhfEqD7U0/7eIagerHuiCtjx9fUwpkO9Ax8hCqgoXbR
	 95yzauNIylmb4jCqS1ESeZR32pZIErByA4Ko5Iq+ScX5xC+PxMr7Jul2ITUnEH8U7Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=unpredictable.fr;
	spf=pass smtp.mailfrom=unpredictable.fr;
	dkim=pass header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=GOM4gaXv;
	arc=none smtp.remote-ip=57.103.64.18
Received: from outbound.pv.icloud.com (pv-2001l-snip4-5.eps.apple.com [57.103.64.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89824606A32C
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 14:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89824606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=GOM4gaXv
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id 166BA1800339;
	Sat, 21 Nov 2026 14:02:09 +0000 (UTC)
X-ICL-RepId: 01a1fe6a-1e82-7019-8587-f0f7bba45029
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr; s=sig1; t=1795269730; x=1826805730; bh=wMttAGKaKYn3TG91ZM0cBnO+/ENftVqYZypNHoi8/zI=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=GOM4gaXvk4hAN21hj3G0mRiMbwwxpUYSHB9Hhw3BmJ21wDgKSQUNq/0XFMWj5BUohy2+MEPRtrI6pZ3rr9O5xMWwt6CNwXQE0/i/oPxCW4zQ0wRqU5pURd3qNWGFkA60/XkPvL/5QBNAGNywJgTniSZxt5w08P3c3mB4+LbOB7ORI/REYI3SJJnz9+QwbmI1j3ids3eHaQfgAFguqBibRCZOL6HS/66KZBA7JaXdTBcv7q2vUwaiJx1f9BlggR65KmhoETe7kN95CnHP1gjwTkydScOE/6L/HRvAp6h+jDuuBQsgcvn46mEgLe10uSq0w7fV2A5mwKUmNpZIvEj0Kg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id EE6B618000AC;
	Sat, 21 Nov 2026 14:02:07 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 0/1] hw/arm/virt: add vhe option for nested virtualization
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <86qzgez3z8.wl-maz@kernel.org>
Date: Sat, 21 Nov 2026 15:01:55 +0100
Cc: Haseeb Ashraf <haseebashraf091@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <volodymyr.babchuk@epam.com>,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 qemu-devel@nongnu.org,
 kvm@vger.kernel.org,
 Eric Auger <eauger@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA21AC27-2A86-47FB-9638-589DCB0A7306@unpredictable.fr>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
 <86qzgez3z8.wl-maz@kernel.org>
To: Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA1NSBTYWx0ZWRfXxZaBvjILzfeo
 XVS4+OpLs9sOtTZIgyGZLwx1k2IV/MEAGEJCYjG8cFWp+w+LRxz9iMs0rLobocOK9kJ6XLpSEl6
 b7aTBdWDYX/4SVGqG84+Rn2spidWEas=
X-Proofpoint-GUID: eo5iWP8DqvDKJ_B2E1nG3LduWfbo8uEF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA1NSBTYWx0ZWRfXw4a44YLeYa8+
 U8lg/nA9H5ZVYweZJPRw0iMsPNmI6hKR2STrQRsoTMWdbwmH515iRyja19pvGA7KBsiW16wMoGa
 cgwhvCemy/2y0jAdFonmGLRmx9bztgTShBw23jBQTrAWgANfDSrOqiFZVR5EdMc/wg/kbv+Y5yE
 OIOPQFBxYHh9i1W2u/juoqsqFCMbFnsIjdqrix4KflyWnk8RXI2O/lpu2suBfToIsnPKzNRQcfL
 5mwvjda6U2dKvKrMiR1tguwMS7EYVI4dws4Vz5edyl4XPcEQmMbrJ5eSercromZGePMgO+NxKF6
 wWtjo8FsrNroUjJGzDKxRM0MdOcaQveNmolK0kFrPunCDoh4ks5KAD7V5GgFnU=
X-Proofpoint-ORIG-GUID: eo5iWP8DqvDKJ_B2E1nG3LduWfbo8uEF
X-Authority-Info-Out: v=2.4 cv=E9xYNqdl c=1 sm=1 tr=0 ts=6b01a462
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=AZoGnDOZhPiq548KR6q9:22 a=RKZYdrCfCo-aMvuV6FxS:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=0RkxlGvoEn2Dvz_ijz8A:9
 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAAB6QpWRUec4rIz35i6LxZMvRU2AdCk2JxD2ql3zTMnF60P6YlbfSiUtJsjFFhmfi
 h/TwTvRUP/G+6svbnKWnwiVd6XRpCQUV9hHQ+sqsnhZwPLrWen04zxkB2svMWZXBuGUz+n
 1F0N70G0PTlw9j/uDwCdfSOUiZdLq8mSN403NbRQHdYvHCp6Zhf35lWx90BIrqN9seFnC2
 39f5zMmjbgOJMHC4qPJCO7VcEEKk6U35Ubs6M6mmSS9eBKm0cZRFrN6aebxacdDDuGA/TO
 5+vmA1SKRsSCPyFJW0GGDUVRluYDLXr9RqHzNllEYVuHXK/XsHuwFWxpTkVwSQVGYkkIAs
 Lqf7r8wB5WpwxwR01iO9lUvWXcM2FYrjpBNjNkBzDev8pBtzEag0ndJDAcbVkACq4h2N+h
 33tTh2RcF/d9oEbSJICJE+70hZQvMdHIdcr2VWYEh/vs3rzpoTbVxYnoC4mEGBP+N0g/0z
 F5/NYQ4EGuVZDghe1UmNRA7fAUBBikztFhbuY3e7pzD88VIcBEwwuZ6bAa42xB9zvFQthi
 mvPVJ3FDz1H2TtJeSFU/AvO2LPcCmE6v1Uu2up1YzU7s8CjhuGb6h+AG2JjtFEJhKzCLSn
 xxXofgciLG8xfC7veoZ9XkSOX77XLUwnalz2Zh7A2Vu/pn7tIpG2WrwKZygucur0t5eZB3
 YnJzu1PiZN3cvOiqWLK1i0wVnrY9XzBM6PL+ISoyszvcxOQmT/QCb7mutoKVxw5RBAZKoq
 0rLW7WPKBABADXE1nOZzCmjrVRNcs0hYBMPzjd0UgcTUYYZdt0oLqUT0ga8jcv1MAezkP8
 KLFMKAAkW/c6zO/MfKfJWqyLgUzf2lAwxyRGIKNH+4RyLniSlsD0sGzb9QTcUJIK0icrpA
 ORsbV3LQY8PsvobyfIchMa8wNkEdQBiFtSJ2WeLxfhp4PLrGBY/ikPsfBA39LwyY9uuGp2
 OH7OteZXH02x+Ul16gq478DPicFkhD4kpXaDdA0bzWjF3RSsc+U1ck8DbDxrtdHSSrdTVf
 L41kSbURiAiVQKT+l750+niv2ypD2vjYtc7qWOQw42VvZbJ8SHc/3VFWdTu6syIRPzyDXI
 SXY0pnBxYTufYvjUvq7kpm79ltXwWiVT/sGnyaSWMZs8VT3z6N6fLGs+oK0CmbM2ZHQjV/
 rKc8iXhJ6D9xp6ql0iwBTc9BCr2PWeoxIDNMkIapKZglFwRS5NFOKlTCtzRT00LSJ10eAp
 ck+QiEEAxAPhkaP2Dv3Tdrl35Qabr+kGqaNwyhtCUMbOja4FaxZVmkHTS8zzRYulsvsWpr
 AExcuQgfnlIp3NMsdTbYOafPasM3CwI51QV4hMHJKVaAMkTf+pyk/cGcFuzBdQSVjOJHlD
 NpoJMVnZuDz0LpraFrlBacnD4MTSXYJxO+Fo5AdbQnj0mGMaKtwnDPRBhoSKCDPtdz9WMC
 zFjRX3X3K1a0Uxyt7J5d2u/Cdw2yDwzDf/GT3Y/Ea0U6xPq0KHhJgTgEk3pA/YX4yvpe95
 OGG+T0LQQHfGoHYvnKINCUiHl+WYjVcZGIpzQ1ewca68



> On 21. Nov 2026, at 14:52, Marc Zyngier <maz@kernel.org> wrote:
>=20
> On Sat, 21 Nov 2026 09:56:35 +0000,
> Haseeb Ashraf <haseebashraf091@gmail.com> wrote:
>>=20
>> Hi,
>>=20
>> The virt board currently enables VHE whenever virtualization=3Don.  =
There
>> is no way to expose EL2 in nVHE mode to a type-1 guest hypervisor.
>>=20
>> This series adds a vhe machine property, enabled by default for
>> compatibility.  Setting vhe=3Doff propagates the requested mode to =
the
>> guest CPU, limits TCG's advertised VHE feature, and requests the KVM
>> HAS_EL2_E2H0 vCPU initialization feature.  Unsupported accelerators
>> and KVM hosts fail clearly instead of silently ignoring the option.
>=20
> + Eric
>=20
> Adding yet another random property for something that is a feature of
> the emulated CPU strikes me as going in the wrong direction.
>=20
> I'd rather see this being directly driven by Eric's feature framework
> as posted at [1], which lets *any* feature being selected by the user.
> The KVM feature flag can then be derived from what the user has
> selected (and matched against what the host can provide).
>=20
> Thanks,

Hi,

Relying on CPU features for nested virt comes with complexity for the =
HVF side,
where the nested virt configuration is part of the accelerator not a =
vCPU.

And it=E2=80=99s too late at vCPU creation time to re-configure this, =
that said I=E2=80=99ve
been considering whether it=E2=80=99d be wise to build a hack in HVF and =
WHP* to defer
VM creation until creation of the first vCPU but that adds other =
problems=E2=80=A6

* currently, we have this behaviour on x86 there where nested virt is =
always=20
set as enabled because of this, and -cpu host,vmx=3Don is only disabling =
exposing
the CPUID bit, not nested virt by itself.

>=20
> M.
>=20
> [1] =
https://lore.kernel.org/r/20261010133725.642498-1-eric.auger@redhat.com
>=20
> --=20
> Without deviation from the norm, progress is not possible.
>=20

