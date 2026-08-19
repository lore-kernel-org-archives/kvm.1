Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E4D26A1AC;
	Wed, 19 Aug 2026 05:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787116990; cv=none; b=POYaMf5n54Dignb57Hb7sS44Ys3grq3WOtQVeZ0znTzPL6eEPN7r0TO+nkDF7p1jfA5CL6WKCmrwARBj1LMGoYxS5zd+kqK9sZtBdwZzcr8uIz7nyeAIFn4uB6n8gaJqGHdKv18aTLbrN17nIJEVY2/M8ZQpeQCmcb7E/3QDl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787116990; c=relaxed/simple;
	bh=PhzYe4H+ADcqvssQG6owupuUWnuD6VXj3nIh0yUaMRY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ii6jvN5kguaGNmnB4Y/nx9wmsibqsNM0/rvgmXL7pCJBeRq7h1X4W+ew9IfAth1QRh7cf+aXtI89QSRGQh8m9xJhi8EQSBrbeUZJUSzSSOFokAF/lVA6RGGc2K4FYgNdQrFQKiRs0EtwAKpudhHnN6fdUzjEI1G1iltQxO23DEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Avb2z3RV; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Avb2z3RV"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 67J5L91C1131270
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Aug 2026 22:21:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 67J5L91C1131270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026072801; t=1787116871;
	bh=C7NV13mMxL9whWk83Do/17kcjOh0WDTLIUqX0IuoHQ0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Avb2z3RVjchOe3g7sK6yb6S2+7AYU6Ib1Emjr8I/UNZExgYt/s1r51JjkaWe3s/iJ
	 zV+M20hOUyKoRYThBIOSk9Fmf9hXZG/2jleaql7IuWbcuipmTOh+kC4LeATiPE7Tkb
	 fNC2JKwRTZmRl5AGBRWCpAF57SWPe5Mfpd8Y1a5p0gsvVE86GTAnsUPoxflELZmOIN
	 x7NtAddui3q2GUZpxIpK4lBP5ElVaM11In2RtKkWmskK7zzqCyEZ98t9ARLQRG6xAk
	 lmSpBcQRxo55u3L2gtUVpWhPNwAumV2tcWJxgJxJ/bpWxz7/DobcUNor32+xfEQXtz
	 XjeyS2AkFSKEg==
Date: Tue, 18 Aug 2026 22:21:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sohil Mehta <sohil.mehta@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
CC: kvm@vger.kernel.org, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Kai Huang <kai.huang@intel.com>, Fuad Tabba <fuad.tabba@linux.dev>,
        Chao Gao <chao.gao@intel.com>, Yosry Ahmed <yosry@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Matlack <dmatlack@google.com>,
        Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
        Kishen Maloor <kishen.maloor@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_2/7=5D_KVM=3A_x86=3A_Use_linear=5F?=
 =?US-ASCII?Q?read=5Fsystem=28=29_to_read_the_TSS_I/O_bitmap?=
User-Agent: K-9 Mail for Android
In-Reply-To: <2f8e907e-1c77-416d-90be-9428ce8242f6@intel.com>
References: <20260806011536.4172258-1-sohil.mehta@intel.com> <20260806011536.4172258-3-sohil.mehta@intel.com> <41a327bd-cbbd-4530-9f30-9175c5840014@linux.intel.com> <2f8e907e-1c77-416d-90be-9428ce8242f6@intel.com>
Message-ID: <CF354E4D-FF68-4DEE-A22B-62EDAD5B7B8D@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 18, 2026 10:03:03 PM PDT, Sohil Mehta <sohil=2Emehta@intel=2Ecom>=
 wrote:
>Thank you for reviewing the patch=2E
>
>On 8/18/2026 8:19 PM, Binbin Wu wrote:
>> On 8/6/2026 9:15 AM, Sohil Mehta wrote:
>>> TSS I/O permission bitmap reads are implicit supervisor accesses which
>>> are subject to Linear Address Space Separation (LASS) enforcement=2E
>>=20
>> I am not sure about it=2E
>>=20
>> According to SDM vol 3a (253668-089US), Chapter "LINEAR-ADDRESS PRE-PRO=
CESSING",
>> section "MODE-BASED ACCESSES AND LINEAR-ADDRESS-SPACE PARTITIONING", it=
 defines
>> and limits "implicit supervisor-mode accesses" to the following operati=
ons:
>
>The way I understand it, this list isn't exhaustive=2E The wording in
>those sections, "Such accesses include the following=2E=2E" and "Examples=
 of
>such accesses include=2E=2E" suggests that this is not limiting=2E
>
>> - accesses to the global descriptor table (GDT) or local descriptor tab=
le (LDT)
>>   to load a segment descriptor
>> - accesses to the interrupt descriptor table (IDT) when delivering an i=
nterrupt
>>   or exception
>> - accesses to the task-state segment (TSS) as part of a task switch or =
change of
>>   CPL
>> - accesses to a user posted-interrupt descriptor (UPID) during user-int=
errupt
>>   notification processing
>>=20
>
>For example, this doesn't list the SENDUIPI instruction's access to the
>UITT (IA32_UINTR_TT)=2E That one is an implicit supervisor-mode access to
>a kernel address at CPL =3D 3=2E
>
>In section 5=2E6=2E1 (Determination of Access Rights), immediately follow=
ing
>the above examples the SDM says:  "All these accesses are called
>implicit supervisor-mode accesses regardless of CPL=2E"
>
>> IIUC, the TSS I/O bitmap read during ordinary instruction execution
>> (under CPL =3D 3) rather than during a task switch or CPL transition, I=
 don't
>> think they fall under the classification of implicit supervisor-mode ac=
cesses=2E
>>=20
>AFAIU, the entire TSS struct (including the I/O bitmap portion) is
>mapped at struct cpu_entry_area using CPU_ENTRY_AREA_BASE with
>PAGE_KERNEL_RO permissions=2E So bit 63 will always be 1 and U/S =3D 0=2E
>
>Yes, the TSS I/O bitmap access happens at CPL =3D 3 but it still has to b=
e
>an implicit supervisor access=2E If it weren't, any user instruction
>access to the I/O bitmap would always generate a fault (even without
>LASS), right?
>
>
>Sohil
>

The I/O bitmap is most definitely an implicit supervisor access=2E
