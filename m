Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245841A500
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970101; cv=none; b=cqFglbYY5AElZoFDrfctbN/LLuTZDXGinN7QAlm0ZiPSQv6lM/NdvLLktnn3itsv9O4Ba6wC3yFHg3yfmrpqjiPZUip1EfWPtx0VmxsSOIPXnzNj/fKMiYYfFLsyP1afqnV88zXESQk/yVBYpoOLaNKb+4N1epCbebdxRLvi8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970101; c=relaxed/simple;
	bh=KoMYTngtcOx3C4ujY5d/IqD3JolqZNXmrrbXHPnn7uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ov1/3F5gufWgDfRH+GODEVtZggm4Q/dxXg8+wBjkgy4mctRZIzJkljCNYaQe39uG/5lhHp0XQxc8y2cyWN4/RmGcOWcaWfpF+j8q78PjIKzVpD3paT2Pskq2LIByJhot4E0XIgub5WC74quKASs93uLI6cC7oxArOgVl8ZX4kII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UC1ExLIn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC1ExLIn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d049069377so34045825ad.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786970099; x=1787574899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KjWXP+qZdAduuExhW3Uw0m7asrTX1tGFHFZbEdR7hI=;
        b=UC1ExLInaldSZdQuIt5H4Gw133eznTnUICAZn0ufJr33S9VUdB4DvH4nB5VnimL6Je
         Hs2p/MWe+aEAlWBooaAIiLxmt91hjed440egfpshYWLKlxLf+6eb7ggUDGbWF4wGoQ7O
         YTWlUgdulxzpMoPdcfJUOQ8mCOglwfxzI2SfeC2AMAFRjsZAxLjETW8dT9EiKbyAe0Mn
         OKa98BbDFHeGOViWR3F0F9Usl5qoiYhKhPiPB19vqSqbiYfeAOKvsjuLaF7OsEIDWcxj
         0srAx/xGRcUQ247rzA7khkRPkqIn3nqK8HKIipuhiwALPWKwlmahYKf8B3g8c0TLjK4K
         3TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970099; x=1787574899;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8KjWXP+qZdAduuExhW3Uw0m7asrTX1tGFHFZbEdR7hI=;
        b=PK3lzPRxOJuFkAYCJ/icQyaNpxMQCnR7zbasMsVt5tPS9223WhIa6OW3h3bpnZf+VV
         6x/VWi6p2bnT7bb56dZIV1QRZyUTosJzrbNLh8dRPWKhu2XAGptSnhwxaPI1dW2ATfoB
         OwsKzThY0D9IkswwhnK9aBuZe/gnFBSbot/VqTgEXC8od5S4KAoW3f9vCnRw4pjx1zkR
         bA5dz5ceIeFhdyIipVPGQfPsc/ykPAwVpLPBIDKiz6Oo6q1cUlb1hs6KHbx8c3j0ks9F
         kVmIWPlEw0tujsSwQtAE6TUwe2CIv7eeFKRf2aU/DWjD7bqZbTeL8eUSzrIOwaCqvgRP
         zCWw==
X-Forwarded-Encrypted: i=1; AHgh+Rpoz7/CUrt6iPuBgOStX9M0JB/I+upvs/6OQ90316RdD5ZWixlYqX0vy1V/MVKUiuY5i0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywjk41aJz+ezygP7nY9l3H9X4euie6mq9usbL2zfP4gJwWq9EE
	RcjhqW29vpnntZWV18yEsLfdZ1881iBVJh2PNLwBq8abfTvB+Ak4o20s
X-Gm-Gg: AR+sD11Z5clUKPVUSIkimjDwPOb7BnCv0Yh4U9v0DPsQY80f4V3wYxc6tBKK4P03DDS
	gQDpMQpIG4kdFBk3qbjGJDaVzWLFbMBnnyed/1uvMM6ZqjbEJGVbJ3y+LHmjLAGmtFy7R667W72
	iBoXXgL+BH6Dxor3ApIFIA7mD9+5U3slXozaKHF04Rmm+wAgr2Ju5GB4Gg4Oie6SDED5HxfbSFw
	/xkrMLyfmVZKXwl5qQ+vU+lf2s/s1KgczcSKdusLyxA8iaWviA5lSu2MXuxMisre5BnKFZNxYNG
	hhRyYq5q0vMtORwx/fpfsiBX66308KfqsDvm6LeiojOSKGZ0zuy1T38+kesvB7SwEEaQVVuBhS/
	Ey0Sg0JDQLYIe1e4jw8OncuGAUnyZljylH3L9BpJfO1RMzopS5Fek166l6XkU1dfc0tFanCrxCl
	defkSZ6eyrokLhh0+z8QseBH55dEPxr6X0eT8jLZcmUfhFkryA9wJr0vKTNkN4rl9cRAckbAfYR
	5UOFWtWX5DB/vagcQ==
X-Received: by 2002:a17:902:d4cf:b0:2ca:660:b1d with SMTP id d9443c01a7336-2d3b0d5eccfmr253638745ad.11.1786970098817;
        Mon, 17 Aug 2026 05:34:58 -0700 (PDT)
Received: from [10.26.143.42] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb511b0esm4947915ad.26.2026.08.17.05.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 05:34:58 -0700 (PDT)
Message-ID: <79ec6855-6764-407f-bf46-add1bdf36b69@gmail.com>
Date: Mon, 17 Aug 2026 20:34:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] KVM: selftests: Improve sea_to_user test
To: Marc Zyngier <maz@kernel.org>, Jiaqi Yan <jiaqiyan@google.com>
Cc: oupton@kernel.org, sebott@redhat.com, gshan@redhat.com,
 yuzenghui@huawei.com, rananta@google.com, joey.gouly@arm.com,
 suzuki.poulose@arm.com, pbonzini@redhat.com, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260130192837.890688-1-jiaqiyan@google.com>
 <86y0le9cvz.wl-maz@kernel.org>
Content-Language: en-US
From: Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <86y0le9cvz.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/26 8:37 PM, Marc Zyngier wrote:
> On Fri, 30 Jan 2026 19:28:37 +0000,
> Jiaqi Yan <jiaqiyan@google.com> wrote:
>>
>> Several improvments to the test for KVM_EXIT_ARM_SEA:
>>
>> - Refactor run_vm to catch GUEST_FAIL, instead of causing confusing
>>    unhandled MMIO kvm exit.
>>
>> - Sync far_invalid to guest.
>>
>> - Exit test with KSFT_SKIP or KSFT_FAIL when should.
>>
>> - Add comment about VM backing memory type.
>>
>> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>> ---
>>   .../testing/selftests/kvm/arm64/sea_to_user.c | 94 +++++++++++--------
>>   1 file changed, 53 insertions(+), 41 deletions(-)
> 
> Overall, this test is still pretty broken.
> 
> For example, on my Altra box:
> 
> maz@filthy-habits:~$ ./sea_to_user
> Random seed: 0x6b8b4567
> # Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
> # Before EINJect: data=0xbaadcafe
> # EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad, einj_hpa=0xbad
> ok 1 # SKIP EINJ table not available in firmware
> 
> Well, not quite. EINJ *is* available, it is just that this test,
> contrary to *all* the other tests, requires some insanely high
> privileges. But the test is making stupid assumption.
> 
> But that's not all:
> 
> maz@filthy-habits:~$ sudo ./sea_to_user
> Random seed: 0x6b8b4567
> # Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
> # Before EINJect: data=0xbaadcafe
> # EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad, einj_hpa=0x80041234bad
> # echo 0x10 > /sys/kernel/debug/apei/einj/error_type - done
> # echo 0x2 > /sys/kernel/debug/apei/einj/flags - done
> # echo 0x80041234bad > /sys/kernel/debug/apei/einj/param1 - done
> # echo 0xffffffffffffffff > /sys/kernel/debug/apei/einj/param2 - done
> # echo 0x1 > /sys/kernel/debug/apei/einj/notrigger - done
> sh: 1: echo: echo: I/O error
> Bail out! Failed to write EINJ entry: Success (0)
> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Failed? Or Success? Who knows...
> 
> But frankly, the whole "embedded shell script" is disgusting. What is
> wrong with driving the injection from the test itself, rather than
> this access()+popen()? popen() itself is a liability (see the man page
> for system()), and should never be used for this sort of things.
> 
>>
>> diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c b/tools/testing/selftests/kvm/arm64/sea_to_user.c
>> index 573dd790aeb8e..4a3511fa1f940 100644
>> --- a/tools/testing/selftests/kvm/arm64/sea_to_user.c
>> +++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
>> @@ -12,6 +12,11 @@
>>    * including the notrigger feature. Otherwise the test will be skipped.
>>    * The under-test platform's APEI should be unable to claim SEA. Otherwise
>>    * the test will also be skipped.
>> + *
>> + * The VM backing memory is tied to HugeTLB 1G hugepage so far. Make sure
>> + * there are more than 4 1G hugepage on the system. They can be allocated
> 
> Why *more than*? Isn't that *at least* instead?
> 
>> + * at runtime by:
>> + *   echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>>    */
> 
> Why can't you provide an adequate diagnostic instead of this stuff:
> 
> maz@filthy-habits:~$ ./sea_to_user
> Random seed: 0x6b8b4567
> ==== Test Assertion Failure ====
>    include/kvm_syscalls.h:58: mem != MAP_FAILED
>    pid=887 tid=887 errno=12 - Cannot allocate memory
>       1	0x0000000000405b4f: __kvm_mmap at kvm_syscalls.h:58 (discriminator 3)
>       2	 (inlined by) kvm_mmap at kvm_syscalls.h:65 (discriminator 3)
>       3	 (inlined by) vm_mem_add at kvm_util.c:1036 (discriminator 3)
>       4	0x0000000000402373: vm_create_with_sea_handler at sea_to_user.c:290
>       5	 (inlined by) main at sea_to_user.c:336
>       6	0x0000ffffb0dc229b: ?? ??:0
>       7	0x0000ffffb0dc237b: ?? ??:0
>       8	0x00000000004027ef: _start at ??:?
>    mmap() failed, rc: -1 errno: 12 (Cannot allocate memory)
> 
> What is preventing you from not requiring huge pages? And not
> requiring 4kB as the base page size?
> 
> Given how broken this is, I'm likely to disable this test until you
> fix it for real.

Pls help review the expect output:

# selftests: kvm: sea_to_user
# Random seed: 0x6b8b4567
# # Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
# # Before EINJect: data=0xbaadcafe
# # EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad, 
einj_hpa=0x2141234bad
# 1..0 # SKIP EINJ debugfs interface not available; run as root with 
CONFIG_ACPI_APEI_EINJ and firmware EINJ support
ok 1 selftests: kvm: sea_to_user # SKIP
# 1 skipped test(s) detected.  Consider enabling relevant config options 
to improve coverage.
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

, and the diff behind:

diff --git a/tools/testing/selftests/kvm/arm64/sea_to_user.c 
b/tools/testing/selftests/kvm/arm64/sea_to_user.c
index a23d74ed45035..7e86cbeb55291 100644
--- a/tools/testing/selftests/kvm/arm64/sea_to_user.c
+++ b/tools/testing/selftests/kvm/arm64/sea_to_user.c
@@ -86,25 +86,32 @@ static u64 translate_hva_to_hpa(unsigned long hva)

  static void write_einj_entry(const char *einj_path, u64 val)
  {
-	char cmd[256] = {0};
-	FILE *cmdfile = NULL;
+	char buf[32];
+	int fd, len, ret;

-	sprintf(cmd, "echo %#lx > %s", val, einj_path);
-	cmdfile = popen(cmd, "r");
+	fd = open(einj_path, O_WRONLY);
+	if (fd < 0)
+		ksft_exit_fail_perror(einj_path);

-	if (pclose(cmdfile) == 0)
-		ksft_print_msg("echo %#lx > %s - done\n", val, einj_path);
-	else
-		ksft_exit_fail_perror("Failed to write EINJ entry");
+	len = snprintf(buf, sizeof(buf), "%#lx\n", val);
+	ret = write(fd, buf, len);
+	if (ret != len)
+		ksft_exit_fail_perror(einj_path);
+
+	close(fd);
+	ksft_print_msg("%#lx > %s - done\n", val, einj_path);
  }

  static void inject_uer(u64 hpa)
  {
-	if (access("/sys/firmware/acpi/tables/EINJ", R_OK) == -1)
-		ksft_test_result_skip("EINJ table no available in firmware");
-
+	/*
+	 * Reading the ACPI EINJ table requires CAP_SYS_ADMIN, so a plain
+	 * access() check gives a false negative for unprivileged runs. Probe
+	 * the debugfs EINJ interface instead: it is only present when both
+	 * firmware and the kernel EINJ driver support error injection.
+	 */
  	if (access(EINJ_ETYPE, R_OK | W_OK) == -1)
-		ksft_test_result_skip("EINJ module probably not loaded?");
+		ksft_exit_skip("EINJ debugfs interface not available; run as root 
with CONFIG_ACPI_APEI_EINJ and firmware EINJ support\n");

  	write_einj_entry(EINJ_ETYPE, ERROR_TYPE_MEMORY_UER);
  	write_einj_entry(EINJ_FLAGS, MASK_MEMORY_UER);
> 
> Thanks,
> 
> 	M.
> 

