Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFBA2DEA89;
	Sun, 10 May 2026 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778440364; cv=none; b=aoGgZr5YaQpYy+P+TICrW4+UV8gShRkvRI6KJBb0DnDgEoLT635VsGUT+4ZIG+FbnBx4iz5E61LExHqIPOkGaoXtQ69pJfG54ahhtsnEyCnlp9atk8vzvAkImtdej5wHu8V4q8nw4jNNdW/xZhL0ikXWrP4/0oLtNr1N+Dy5Bb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778440364; c=relaxed/simple;
	bh=rZhCq3qZ6tvo9NLSJGM1By4v1vK0X2i9cEEBiILpKHM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=l/u6xfCz47N9TLvja2FFVuq8JEF/1ycosOK0Tgd7Hb/hL+j+EbB8C6LPkh+h0m/RvF0HY7qTd9GIZrsJDeUgE/j0a8mawygC1vJAYDoaZIrov3YitOQV4UHQ+OUTbAInLSejwu1oIqvN/FDWEzAOTG9dGdP/PG2KMIlmLR4Ab0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=biOVcBpB; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="biOVcBpB"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 64AJBO7q180763
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 10 May 2026 12:11:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 64AJBO7q180763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026042601; t=1778440286;
	bh=rZhCq3qZ6tvo9NLSJGM1By4v1vK0X2i9cEEBiILpKHM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=biOVcBpBDneZDpsUsX/ZgnCZdgv6temOW9bJfqp7r4/zVSp4PdlyleDNCW5AHU8oF
	 kEcOFMEBi7y+EB22tHQE5RqodA9aI+lZbleadCqvYiQWT0Q0IjxfEWWRTI7Hsh+lvY
	 qcDwBITZIBJJ+yRJp4T7brJ8tMjYvDrp4z7Vmpe4kq9gpiOxXwP1eU1ymENnAn8/rK
	 Jat8fYUesElVAqBhq2h1reWEr6EnuJ0dnck09i9e93WN11tZtpsCK6ADFDJE2e/4mL
	 2jZaVr6oE1aCCHNVDbLLtivlS5VKkNclz1MYod8e1KQ3HrmsKMNAv2FkkGdLr0ESv/
	 GQ/qsPEA/0z/A==
Date: Sun, 10 May 2026 12:11:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Woodhouse <dwmw2@infradead.org>,
        Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kselftest@vger.kernel.org
CC: seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, shuah@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        jgross@suse.com, joe.jin@oracle.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/5=5D_KVM=3A_x86=3A_account_K?=
 =?US-ASCII?Q?VM=5FSET=5FCLOCK_downtime_in_steal_time?=
User-Agent: K-9 Mail for Android
In-Reply-To: <09b261dafa3b50d358debe1fb13163703bc6e0a1.camel@infradead.org>
References: <20260505003044.78693-1-dongli.zhang@oracle.com> <20260505003044.78693-4-dongli.zhang@oracle.com> <09b261dafa3b50d358debe1fb13163703bc6e0a1.camel@infradead.org>
Message-ID: <2C6E66BA-B225-41E7-A1F9-E6B2DAE0B392@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 10, 2026 11:54:38 AM PDT, David Woodhouse <dwmw2@infradead=2Eorg> wr=
ote:
>On Mon, 2026-05-04 at 17:30 -0700, Dongli Zhang wrote:
>> The KVM_CLOCK_REALTIME has been introduced to help track the downtime o=
f
>> live migration=2E KVM uses that realtime value to advance guest clock, =
but
>> the same blackout is not reflected in KVM steal time=2E
>>=20
>> Account that same delta in steal time directly in kvm_vm_ioctl_set_cloc=
k(),
>> only when KVM_CLOCK_REALTIME is used=2E This keeps the KVM-only solutio=
n
>> self-contained and avoids adding a new KVM ioctl or requiring additiona=
l
>> userspace changes (i=2Ee=2E QEMU)=2E
>>=20
>> Record the per-VM downtime delta when KVM_SET_CLOCK receives
>> KVM_CLOCK_REALTIME, and fold it into the existing x86 steal accounting
>> path=2E Initialize each vCPU's local cursor
>> (vcpu->arch=2Est=2Elast_downtime_steal) when the guest enables
>> MSR_KVM_STEAL_TIME so previously accumulated blackout is not charged=2E
>>=20
>> Note that this means a vCPU may observe additional steal time after
>> blackout even if the host side contribution from current->sched_info
>> did not increase during that interval=2E
>>=20
>> Signed-off-by: Dongli Zhang <dongli=2Ezhang@oracle=2Ecom>
>
>I really don't want to see KVM_CLOCK_REALTIME used for anything more
>than it already is=2E Or, indeed, even for that=2E
>
>There is precisely *one* place where it's OK to use 'real time' as a
>comparator, and that's when setting the guest's TSC=2E And even then it
>should be using TAI not UTC unless you like your guests' clocks jumping
>around by a second if you migrate at the wrong time=2E KVM_CLOCK_REALTIME
>was never the right thing to use, for anything=2E
>
>The KVM clock is a function of the guest's TSC (see
>KVM_SET_CLOCK_GUEST), and steal time is a function of that (as it's
>measured in nanoseconds)=2E
>
>Don't bring UTC into it *anywhere*=2E
>
>

Unfortunately TAI is often unavailable=2E One can hope that the proposal o=
f abolishing leap seconds by 2035, fixing the TAI-UTC offset permanently, a=
ctually happens=2E The difference between atomic and solar time is better h=
andled with the already-existing "time zones" mechanism, which tends to cha=
nge far more frequently for entirely different reasons than the TAI-UT1 dif=
ference slowly accumulates=2E
