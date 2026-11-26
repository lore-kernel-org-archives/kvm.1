Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.68.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715769;
	b=bfZFENgUm8VtIsZ/Ipicj49MDexpvg01AQmKk9qR2H/bCwA71n7OAfq4AoqXjF6UEHyM
	 KEWEDtdOqBB6LCTbmg6uN2TSUBAv+4t+Bmi2AxsTtdPMjGfgkuqvpNrKJmWVut0kAI+zf
	 Llud8ZbnYAvmAZAs83joxcu0888cqihh+nU9sMI+/mawB81AS0u9kpC1cUfn1dx5SkNZX
	 GypiDIEHt5ahdHau4Mee7hzyUsH8b6ZjrvQCSb1Of97PZv//Gcqn3xmrEDYxCG0vGNmyG
	 DWxoOiyhKmVKMKw4KK87uPOZ8NOlpurPK2POCgVRqGCKNHb+1L6AdPDNdhjpWQlm22Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715769;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:Content-Type:Mime-Version:Subject:
	 From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Info-Out:X-JNJ;
	bh=8fhhChzAZkPvLNecmDufydiFYxuMhL8zNn1PPLXOhbY=;
	b=VBKYBFysb7RRlzHCHJBG6O9LlCA5FcCJORbpycvNF7Wy+RbKRikFZUsefYiwzUeEZjXt
	 A8knFm7JVaNOE/TcGr7HlQxcOWYRYw/vR7hRhXQJKI6bFZrGk3luPdd3Gi10L/TLQBwJl
	 llcQphoZRAhp7+aww+yv65q0aJ/Eq0r04sy1qlS9iFtjkcfvDyculqoBXCh7CVc2wPjDQ
	 vy+man6tVdQ2VXBmaqN26+EdVGAzWnJiFpyfqxrb0ABNo+zaX9F5KFShJ/4SJCKrvrSEL
	 YJR1U1UXXG+xdncMuZPF5mAPJhp6rTrnpmZkPUv0KYGb487TUjDnbqTFRvxx1di3mXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=unpredictable.fr;
	spf=pass smtp.mailfrom=unpredictable.fr;
	dkim=pass header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Q73iIjc5;
	arc=none smtp.remote-ip=57.103.68.194
Received: from outbound.mr.icloud.com (mr-2002b-snip4-1.eps.apple.com [57.103.68.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE8606A323
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0FE8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Q73iIjc5
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPS id 3299818001E6;
	Thu, 26 Nov 2026 17:56:04 +0000 (UTC)
X-ICL-RepId: 01a21900-12a2-730b-91ea-54ed01ff9dc2
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr; s=sig1; t=1795715767; x=1827251767; bh=8fhhChzAZkPvLNecmDufydiFYxuMhL8zNn1PPLXOhbY=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=Q73iIjc599PelmS50qJUJzS2UtE8KGvibHV3jFcXc3el2aMMRODweAarLEmleMJu8x+/RgFk0D0Zj4FmbU/7v7lv+Qm1XR1auR16ZsvV+B8IgBXuxePiLQlhLmLRSqEMT3chF1bYLgj6PlYW+2oE+kiTthrgw0QXsM0KiaHIi9ooDTX7XFQAOf1+svNIGCyZt9AVEm3dJv9YYWmzHKxd4a7+fby9gUguihhJSIQRdUF6J7EVhh6lHFM4wsZrzHKucaCk9g2JaSMvlbSORerSDf4tyCmaJLyOnz5DLU07MhGj3MtiRz8vLB/cdp7K5pXqbjZKo/MRCHM1I+yJNXrJyA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPSA id 47E341800328;
	Thu, 26 Nov 2026 17:56:02 +0000 (UTC)
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
Subject: Re: [RFC PATCH v3 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <fa7522a1-1d0e-4bdf-aad9-767c08878cd1@redhat.com>
Date: Thu, 26 Nov 2026 18:55:50 +0100
Cc: Haseeb Ashraf <haseebashraf091@gmail.com>,
 Khushit Shah <khushit.shah@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 qemu-devel@nongnu.org,
 kvm@vger.kernel.org,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>,
 Marc Zyngier <maz@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9746F4BB-6688-4B39-AC6E-DC0295599927@unpredictable.fr>
References: <8A57A0C8-9E85-4BAC-803A-DAFC6DBD6612@nutanix.com>
 <20261126062002.136401-1-haseebashraf091@gmail.com>
 <fa7522a1-1d0e-4bdf-aad9-767c08878cd1@redhat.com>
To: Eric Auger <eauger@redhat.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3MCBTYWx0ZWRfXzZ9U33Bqmp+N
 VP4we7rMqG8j480doLR0COMOd/dTzgwtduQJiFvy3qU2iwxEEqaIHSqV1aWMmXJJeJvibx4lImk
 /pD9B016Ws1dv2a18npL8SRBna9i7GjNFRi6W34dR1vnpDDvrMhJeKdj8tXJ6/pDd/pC3TJO8rv
 m+YYcI4ZDCQqD5hrGD0Hk0/A8NLqnfiVPOftehuX+wH4hbH8nYGZsRaV/3/CoYgwPJsUNPPNM4W
 y/V8asB0qR7LaggpuLUiDeaakn7v3psSUUgfXkq+gKNxI5xPy+j9qGMab46mOngzTNw2bL4tS+/
 uQCQhqFAnCgSQS3bSGmGEZhbONaIUwPDMUbYggPzholscr3ZeBLhcX1TT4uWPA=
X-Proofpoint-GUID: R24cERRUtmaM3jZFPe9MfxytT2fD3nwH
X-Proofpoint-ORIG-GUID: R24cERRUtmaM3jZFPe9MfxytT2fD3nwH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3MCBTYWx0ZWRfX3stmnvbP/ky3
 fCgEMqRBs2NZtqb3lstKjTlDlHodONGsMi1+dLMzicpcL9PmV7lv8OwqUEzynvfo/RXHUvwN4yQ
 Y92ce4eu3YgIyYG1SRERQTrqKp0oUNg=
X-Authority-Info-Out: v=2.4 cv=XZAcX455 c=1 sm=1 tr=0 ts=6b0872b6
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wbbCu9YnSpm8ZdSLOl1R:22 a=_mclknXjrhVi08tC7Eh6:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=aMxLMesAV-4Bx-ERIwIA:9
 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAABJo+6C+pgujg2X+Of6/SxSPUScWOJG1a2iAjDB60Eni78lwFoODYGAFSc4BUc4f
 Q7AZfnBj1V8gwv5dLB0ph1uO46wKzKMUNLoRYgcMqSDMTW6+2+t1C7SWmc3iC4F9z4LQR4
 jey0tk3eFlj6zuqUC9u2LLTKCXK5e6DXAIeCiqogIOLZ7ZfN6/lQisl89I++GqYf7VBR0p
 mUWClCr4Kjfl0upVHzO2pbvvjASAOHyIUc4eHL/UBzSZkSt6TebXJ7jtJEDVmeW+IQQaSD
 Ct7aT+I8SJ0RYY3Cei/EjaThDfOb566uxObISJeV43VL5huHY2Iyt+UeKqhDcaajF84jJA
 IK1xCwLAAgUJDsHGHmojigds9s9610tZJPoXXTBO/byr314LPk5/pI9N+X3Xo6EvtsT7nR
 Em9S6hghIpzJxddwnFkc2fiM6s93lKoaFtpa8ctSItrK0ZDTtoP+XWqyoRyd4M8CLcg+cb
 T7/Cwlw8vDr+Ndv7FgZFIoN7VZiCc98QXsRxJGP2KCQ7WYH0zfAWssltHHc9JjfKrv2sCX
 d1BFPuwErgebHyxfRiVUi9+JoYIHpPopzc7x7QP/bwYw+alD8aOb8/0QSYOpTLZXDVjYxU
 3ToOmuvYNxMe8LhJd3lKC6WkdHYM1f7M59WL6F1AhXga9meI4aZskhKoQ7QnVOVOBU0XyE
 6cT7zA/bMlLz+mDJ0DhkMRVkCvVwp0ynA0uno8DAk1xdpZn+D7bW8N46mftLuHz56MDFRj
 JgD6eX1E2N0OFVwuvHdNBoeCcKB5Hd8cA5QNDdCyAlPN/ZTSDc5G4OS5nx5tf7Z/bxOGjT
 G2apf51+UZzbzcfIlU9FM10Y7o7+vRRfvdvXpZN1jLm9sj4gQkvw+ACw0PySocc71onbIq
 SoN1sfHt38AZG6oeLwZh0ip+I+M7msmzKSoGqaX6TxqGi9wt1RyGG7rnIl6QS3ZGDvAGpr
 Vs8cKT9HrbFiNwE0wkyP+HuO45lE08JnzDPl3tBkwKlq5k/VZC/lBuwMZY4oBWS2RHJS7e
 nWbtanNJVPfDugCo40a1xfFsaiOAf9a/ln6U0q/e+JJcgi5/5e+1WBs329tect8gQ0MUp/
 eJCQs0XcRHPjHRGrAyj/Lrt3I5N8v3UofcsRelgzI819CHu3QVX98inxEsE9VwnEYzFrSD
 uDlIQvzcACarZz57YRRHBL98KU3aL930YwRjWc05sFX0hUJtW8YOclh70tqn8fQPNu+CS3
 uhImCbruf48dt8xlcInaK0rEDztd5XYemhkyi3BDOb6S21GMt67EmTlQN1de+WaiIpWzS8
 uXFO2mBc9xt97VAIHwKMoQMhtYFgwrZNUPG4AMNLmje0VNwn2GRn+ibS+HfN2XDQ4ktBtF
 CGHBFGJHyVsAyvLIBX/KjrCbJJH6tdtVRZ0dtKaVgrYGRe41ex3cM1gD+7CSPhPknlt+XP
 NiBj5WwVeKgUaG9Apndzuj+I+JWmB66614P2M96c1pZlhggJCeE9y2Wjle3DQ/gJ0d9pYb
 mMylHdedyYUps6fX1wNSvGF7+y5Wd6XoJGNChtT2cTmqiySUp0nbbjAwVj/SyEIa0e4Owy
 UlrVlFTbylOcwDImtmj0f2fg+AV6Fb8Td/hnlwP4ubOzutB0Cjj/b281QYmreTdt+asmTL
 vC4=



> On 26. Nov 2026, at 18:13, Eric Auger <eauger@redhat.com> wrote:
>=20
> Hi Haseeb, Khushit,
>=20
> On 11/26/26 7:20 AM, Haseeb Ashraf wrote:
>> Hi Khushit,
>>=20
>> On 26/11/26 11:38, Khushit Shah wrote:
>>=20
>>> There are many such fields like PAuth (APA, GPA, =E2=80=A6) and SVE. =
They are
>>> not part of the SYSREG_ framework as there already exists boolean
>>> properties for them.
>>> (Another way to do this is having -cpu =E2=80=A6,vhe=3Don/off =
property)
>>=20
>> The v1 series was closer to what you are suggesting: it added a
>> standalone `vhe=3Don/off` property and used it to select the
>> requested KVM vCPU initialization mode.
>>=20
>> Could you please also review the v1 implementation?
>>=20
>> =
https://lore.kernel.org/qemu-devel/20261121095636.289814-1-haseebashraf091=
@gmail.com/
>=20
> It is a valid point to question the addition of new vcpu properties =
(especially low level ones like this one) while we plan to introduce =
those SYSREG low level properties. For composite properties which stand =
at higher level (tweaking several knobs at KVM VCPU init or IDREG field =
level) it still makes sense though.
>=20
> Until now we have proposed for the host vcpu to expose SYSREG props =
only for KVM writable ID reg fields. On the other hand, named vcpu =
models require to have ALL ID reg fields exposed. If we were to extend =
this infra to other archs or TCG, we may also need to expose ALL fields =
and just have different implementation for setters/getters depending on =
the writability mode (REG WRITE or VCPU init or anything else).

Hi,

Given that for HVF we need to say whether it=E2=80=99s VHE or nVHE =
before vCPU creation time, I think
that maybe bolting it on as a vCPU property isn=E2=80=99t the best =
idea=E2=80=A6

Thank you,
-Mohamed
>=20
> Thanks
>=20
> Eric>
>> I changed direction for v2 following Marc's feedback against adding a
>> separate property.
>>=20
>> Thanks,
>> Haseeb
>=20
>=20

